"use strict";

const ENABLE_COVERAGE = !!process.env.CI;

module.exports = {
  collectCoverage: ENABLE_COVERAGE,
  collectCoverageFrom: [
    "<rootDir>/src/**/*.js",
    "!<rootDir>/node_modules/",
    "!<rootDir>/config/jest/",
  ],
  projects: [
    {
      displayName: "test",
      setupFiles: ["<rootDir>/config/jest/run_spec.js"],
      testRegex: "jsfmt\\.spec\\.js$|__tests__/.*\\.js$",
      snapshotSerializers: ["<rootDir>/config/jest/raw-serializer.js"],
      testEnvironment: "node",
    },
  ],
};
