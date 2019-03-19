#!/bin/sh

release_ctl eval --mfa "Pushupbot.ReleaseTasks.migrate/1" --argv -- "$@"
