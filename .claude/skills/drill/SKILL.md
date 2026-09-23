---
name: drill
description: Generates timed pacing drills — interval sets with target pace, reps, rest, and a progression — for running, swimming, speaking, or typing practice. Use when the user asks for pacing drills, interval workouts, or timed practice sets.
---

# Pacing drill generator

## Ask (only if missing)
- Activity (run, swim, bike, speech, typing)
- Current baseline (e.g. 5 km in 25:00, 140 wpm, 40 wpm)
- Goal and weeks available

## Output
A table per session:

| Set | Reps × Distance/Duration | Target pace | Rest | Cue |
|-----|--------------------------|-------------|------|-----|

Plus:
- Warm-up and cool-down lines.
- Week-by-week progression (pace or volume change ≤ 10% per week).
- How to tell the pace is right (effort, heart-rate zone, or error rate).

## Rules
- Derive every target pace from the stated baseline; show the math once.
- Never exceed a 10% weekly increase.
