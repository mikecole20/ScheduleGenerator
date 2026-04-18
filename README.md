# ScheduleGenerator

A command-line tool for generating college football schedules with reproducible, seeded randomization.

## Overview

ScheduleGenerator creates non-conference football schedules for SEC teams (user teams) against teams from various conferences (CPU teams). The tool ensures required rivalry games are scheduled and randomly assigns remaining matchups using a seeded random number generator for reproducibility.

## Features

- **Reproducible Schedules**: Use a seed value to generate the same schedule multiple times
- **Required Matchups**: Automatically includes traditional rivalry games:
  - Florida vs. Florida State
  - Georgia vs. Georgia Tech
  - South Carolina vs. Clemson
- **Random Assignment**: Randomly assigns remaining non-conference games
- **Home/Away Designation**: Randomly designates one game per team as an away game
- **Deterministic Output**: Same seed produces the same schedule every time

## Requirements

- macOS (or Linux with Swift support)
- Swift 5.9 or later
- Xcode 15.0 or later (for building on macOS)

## Building

### Using Xcode

1. Open `ScheduleGenerator.xcodeproj` in Xcode
2. Select the `ScheduleGenerator` scheme
3. Build the project (⌘B)
4. Run the executable from the Products folder, or use the Run command (⌘R)

### Using Swift Package Manager (Command Line)

If you have a `Package.swift` file, you can build using:

```bash
swift build -c release
```

The executable will be located at `.build/release/ScheduleGenerator`.

## Usage

```bash
ScheduleGenerator [--seed <seed>]
```

### Options

- `--seed`, `-s`: (Optional) Provide a custom seed to generate a stable, reproducible schedule. If not provided, a random seed will be used and displayed.

### Examples

**Generate a schedule with a random seed:**
```bash
ScheduleGenerator
```

**Generate a schedule with a specific seed:**
```bash
ScheduleGenerator --seed 12345
```

**Using the short form:**
```bash
ScheduleGenerator -s 12345
```

## Output Format

The tool outputs schedules for each user team in alphabetical order. Each schedule shows:
- Team name
- List of opponents with "vs" (home game) or "at" (away game) designation
- One randomly selected game per team is designated as an away game

Example output:
```
Alabama
----------
vs Arizona
vs Boston College
at Clemson

Arkansas
----------
vs California
vs Duke
at Florida State

...
```

## Schedule Rules

- All teams play 3 non-conference games
- Required rivalry games are automatically scheduled:
  - Florida vs. Florida State
  - Georgia vs. Georgia Tech
  - South Carolina vs. Clemson
- Each team has exactly one away game designated randomly
- No CPU team is scheduled against multiple user teams

## Technical Details

- Uses `swift-argument-parser` for command-line argument parsing
- Implements a seeded random number generator using `srand48`/`drand48` for cross-platform reproducibility
- Ensures no duplicate matchups across all schedules

## Error Handling

The tool may throw the following errors:
- `missingTeamSchedule`: A team's schedule was not properly initialized
- `noRemainingCpuTeams`: No CPU teams remain to schedule (should not occur with current team counts)
- `tooManyGamesScheduled`: A team already has more games scheduled than expected
