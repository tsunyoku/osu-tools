#!/usr/bin/env bash

SRC="../osu/osu.Game.Rulesets.Osu/Difficulty"
DST="BaselineOsuRuleset/Difficulty"

rm -rf "$DST"
mkdir -p "$DST/Evaluators/Aim" "$DST/Evaluators/Speed" "$DST/Preprocessing" "$DST/Skills" "$DST/Utils"

cp "$SRC/OsuDifficultyAttributes.cs"           "$DST/"
cp "$SRC/OsuDifficultyCalculator.cs"           "$DST/"
cp "$SRC/OsuLegacyScoreMissCalculator.cs"      "$DST/"
cp "$SRC/OsuLegacyScoreSimulator.cs"           "$DST/"
cp "$SRC/OsuPerformanceAttributes.cs"          "$DST/"
cp "$SRC/OsuPerformanceCalculator.cs"          "$DST/"
cp "$SRC/OsuRatingCalculator.cs"               "$DST/"
cp "$SRC/Evaluators/Aim/AgilityEvaluator.cs"   "$DST/Evaluators/Aim/"
cp "$SRC/Evaluators/Aim/FlowAimEvaluator.cs"   "$DST/Evaluators/Aim/"
cp "$SRC/Evaluators/Aim/SnapAimEvaluator.cs"   "$DST/Evaluators/Aim/"
cp "$SRC/Evaluators/FlashlightEvaluator.cs"    "$DST/Evaluators/"
cp "$SRC/Evaluators/ReadingEvaluator.cs"       "$DST/Evaluators/"
cp "$SRC/Evaluators/Speed/RhythmEvaluator.cs"  "$DST/Evaluators/Speed/"
cp "$SRC/Evaluators/Speed/SpeedEvaluator.cs"   "$DST/Evaluators/Speed/"
cp "$SRC/Preprocessing/OsuDifficultyHitObject.cs" "$DST/Preprocessing/"
cp "$SRC/Skills/Aim.cs"                        "$DST/Skills/"
cp "$SRC/Skills/Flashlight.cs"                 "$DST/Skills/"
cp "$SRC/Skills/Reading.cs"                    "$DST/Skills/"
cp "$SRC/Skills/Speed.cs"                      "$DST/Skills/"
cp "$SRC/Utils/LegacyScoreUtils.cs"            "$DST/Utils/"

find "$DST" -name "*.cs" -exec sed -i 's/osu\.Game\.Rulesets\.Osu\.Difficulty/BaselineOsu.Difficulty/g' {} +

sed -i 's/using osu\.Game\.Beatmaps;/using osu.Game.Beatmaps;\nusing osu.Game.Rulesets;/' "$DST/OsuDifficultyCalculator.cs"
sed -i 's/using osu\.Game\.Rulesets\.Osu\.Scoring;/using osu.Game.Rulesets.Osu;\nusing osu.Game.Rulesets.Osu.Scoring;/' "$DST/OsuPerformanceCalculator.cs"
