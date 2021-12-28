# Changelog

## Unreleased

### Fixed

- Exclude disabled offenses.
- Uniq paths at PathFinder.

### 0.7.0 - 2021-12-28

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
