import ArgumentParser

@main
struct ScheduleGenerator: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "ScheduleGenerator",
    abstract: "Generate college football schedules with reproducible, seeded randomization.",
    discussion: """
    ScheduleGenerator creates non-conference football schedules for SEC teams against teams 
    from various conferences. The tool ensures required rivalry games are scheduled and 
    randomly assigns remaining matchups using a seeded random number generator for reproducibility.
    
    Required Matchups:
    - Florida vs. Florida State
    - Georgia vs. Georgia Tech
    - South Carolina vs. Clemson
    
    Schedule Rules:
    - Florida and Georgia play 2 non-conference games (they must play each other)
    - All other teams play 3 non-conference games
    - Each team has exactly one away game designated randomly
    - No CPU team is scheduled against multiple user teams
    
    Use --help or -h to see this help message.
    """,
    version: "1.0.0"
  )
  
  @Option(name: .shortAndLong, help: "Provide a custom seed to generate a stable, reproducible schedule. If not provided, a random seed will be used and displayed.")
  var seed: Int? = nil

  mutating func run() throws(ScheduleGeneratorError) {
    let seed = seed ?? Int.random(in: .min...Int.max)
    print("Generating schedule with seed: \(seed)\n")

    var randomNumberGenerator = SeededRandomNumberGenerator(
      seed: seed
    )

    var schedules: [UserTeam: Set<CpuTeam>] = [:]
    for userTeam in UserTeam.allCases.sorted() {
      schedules[userTeam] = []
    }

    // Required out-of-conference games
    schedules[.florida]?.insert(.floridaState)
    schedules[.georgia]?.insert(.georgiaTech)
    schedules[.southCarolina]?.insert(.clemson)

    // Teams to choose from
    var unscheduledCpuTeams: Set<CpuTeam> = Set(CpuTeam.allCases)

    // Remove the teams from required games already scheduled
    for schedule in schedules.values {
      for cpuTeam in schedule {
        unscheduledCpuTeams.remove(cpuTeam)
      }
    }

    // Build a schedule for each team
    for userTeam in UserTeam.allCases.sorted() {
      let gamesToSchedule = switch userTeam {
      case .florida,
           .georgia:
        // Florida and Georgia must play each other.
        // This can be removed when they're in the same conference.
        2
      default:
        3
      }

      // Get copy of existing schedule
      guard var teamSchedule = schedules[userTeam] else {
        throw .missingTeamSchedule(userTeam)
      }

      guard gamesToSchedule >= teamSchedule.count else {
        throw .tooManyGamesScheduled(userTeam, gamesToSchedule, teamSchedule.count)
      }

      while teamSchedule.count < gamesToSchedule {
        guard let cpuTeam = unscheduledCpuTeams.sorted().randomElement(using: &randomNumberGenerator) else {
          throw .noRemainingCpuTeams
        }
        // Add new CPU team to schedule
        teamSchedule.insert(cpuTeam)
        // Remove CPU team from pool
        unscheduledCpuTeams.remove(cpuTeam)
      }

      // Save the new schedule
      schedules[userTeam] = teamSchedule
    }

    // Print schedules
    for (userTeam, schedule) in schedules.sorted(by: { $0.key < $1.key }) {
      let roadGame = schedule.sorted().randomElement(using: &randomNumberGenerator)

      print(
        """
        \(userTeam.rawValue)
        ----------
        """
      )

      for cpuTeam in schedule.sorted() {
        print("\(cpuTeam == roadGame ? "at" : "vs") \(cpuTeam.rawValue)")
      }

      print("\n")
    }
  }
}
