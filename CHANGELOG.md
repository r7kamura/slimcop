# Changelog

## Unreleased

### Changed

- Use templatecop.

## 0.12.0 - 2022-01-12

### Changed

- Keep trying auto-correction up to 7 times until no offense detected.

## 0.11.0 - 2022-01-10

### Changed

- Detect offenses from code that containing `if`, `unless`, `do`, etc.

## 0.10.0 - 2022-01-06

### Added

- Use .slimcop.yml as its 1st default config file.

## 0.9.1 - 2022-01-04

### Fixed

- Fix $LOAD_PATH at ./exe/slimcop.

## 0.9.0 - 2022-01-02

### Changed

- Require slimi >= 0.5.1 to extract Ruby code from Ruby attribute.

### Fixed

- Fix -v and --version option.

## 0.8.0 - 2021-12-29

### Changed

- Use .rubocop.yml by default.
- Use "**/*.slim" by default.

### Fixed

- Fix bug that --no-color was not working.

## 0.7.1 - 2021-12-29

### Fixed

- Exclude disabled offenses.
- Uniq paths at PathFinder.

## 0.7.0 - 2021-12-28

### Changed

- Re-use RuboCop's progress formatter as our default formatter.

## 0.6.0 - 2021-12-28

### Added

- Add -c, --config CLI option to customize RuboCop config.

### Changed

- Not investigate all files then auto-correct them, but do it for each file.
- Sort processed files in alphabetical order.
- Disable Lint/UselessAssignment by default.

## 0.5.0 - 2021-12-27

### Changed

- Disable Lint/EmptyFile by default.
- Disable Style/RescueModifier by default.

### Fixed

- Fix NoMethodError on some RuboCop offenses.
- Fix bug when uncorrectable RuboCop offense exists.

## 0.4.0 - 2021-12-26

### Added

- Support glob pattern on arguments of executable.

### Fixed

- Fix bug on parsing invalid syntax Ruby code.

## 0.3.0 - 2021-12-25

### Added

- Show Slim file path on Slim syntax error.

### Changed

- Require slimi >= 0.4 for :file option handling.

## 0.2.0 - 2021-12-21

### Added

- Add --color and --no-color option.

### Changed

- Improve offenses CLI output format.
- Return exit status 1 if any offense found.

## 0.1.0 - 2021-12-21

- Initial release.
