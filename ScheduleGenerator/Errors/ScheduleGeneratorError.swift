enum ScheduleGeneratorError: Error {
  case missingTeamSchedule(UserTeam)
  case noRemainingCpuTeams
  case tooManyGamesScheduled(UserTeam, _ expectedCount: Int, _ currentCount: Int)
}
