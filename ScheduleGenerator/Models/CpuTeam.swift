enum CpuTeam: String, CaseIterable {
  // ACC
  case bostonCollege = "Boston College"
  case california = "California"
  case clemson = "Clemson"
  case duke = "Duke"
  case floridaState = "Florida State"
  case georgiaTech = "Georgia Tech"
  case louisville = "Louisville"
  case oregonState = "Oregon State"
  case pittsburgh = "Pittsburgh"
  case smu = "SMU"
  case stanford = "Stanford"
  case syracuse = "Syracuse"
  case virginia = "Virginia"
  case virginiaTech = "Virginia Tech"
  case wakeForest = "Wake Forest"
  case washingtonState = "Washington State"
  // BIG 12
  case arizona = "Arizona"
  case arizonaState = "Arizona State"
  case baylor = "Baylor"
  case byu = "BYU"
  case cincinnati = "Cincinnati"
  case colorado = "Colorado"
  case houston = "Houston"
  case iowaState = "Iowa State"
  case kansas = "Kansas"
  case kansasState = "Kansas State"
  case oklahomaState = "Oklahoma State"
  case tcu = "TCU"
  case texasTech = "Texas Tech"
  case utah = "Utah"
  case westVirginia = "West Virginia"
  // BIG TEN
  case illinois = "Illinois"
  case indiana = "Indiana"
  case iowa = "Iowa"
  case maryland = "Maryland"
  case michigan = "Michigan"
  case michiganState = "Michigan State"
  case minnesota = "Minnesota"
  case nebraska = "Nebraska"
  case northwestern = "Northwestern"
  case ohioState = "Ohio State"
  case oregon = "Oregon"
  case pennState = "Penn State"
  case purdue = "Purdue"
  case rutgers = "Rutgers"
  case ucla = "UCLA"
  case usc = "USC"
  case washington = "Washington"
  case wisconsin = "Wisconsin"
  // Independent
  case notreDame = "Notre Dame"
}

extension CpuTeam: Comparable {
  static func < (
    lhs: CpuTeam,
    rhs: CpuTeam
  ) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
}
