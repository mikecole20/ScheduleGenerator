enum UserTeam: String, CaseIterable {
  case alabama = "Alabama"
  case arkansas = "Arkansas"
  case auburn = "Auburn"
  case florida = "Florida"
  case georgia = "Georgia"
  case lsu = "LSU"
  case miami = "Miami"
  case mississippiState = "Mississippi State"
  case missouri = "Missouri"
  case northCarolina = "North Carolina"
  case oklahoma = "Oklahoma"
  case oleMiss = "Ole Miss"
  case southCarolina = "South Carolina"
  case tennessee = "Tennessee"
  case texas = "Texas"
  case vanderbilt = "Vanderbilt"
}

extension UserTeam: Comparable {
  static func < (
    lhs: UserTeam,
    rhs: UserTeam
  ) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
}
