$Src = "..\..\osu\osu.Game.Rulesets.Osu\Difficulty"
$Dst = "BaselineOsuRuleset\Difficulty"

if (Test-Path $Dst)
{
    Remove-Item -Recurse -Force $Dst
}

$subdirs = @(
    "$Dst\Evaluators\Aim",
    "$Dst\Evaluators\Speed",
    "$Dst\Preprocessing",
    "$Dst\Skills",
    "$Dst\Utils"
)

foreach ($d in $subdirs)
{
    New-Item -ItemType Directory -Force $d | Out-Null
}

$files = @(
    "OsuDifficultyAttributes.cs",
    "OsuDifficultyCalculator.cs",
    "OsuLegacyScoreMissCalculator.cs",
    "OsuLegacyScoreSimulator.cs",
    "OsuPerformanceAttributes.cs",
    "OsuPerformanceCalculator.cs",
    "OsuRatingCalculator.cs"
)

foreach ($f in $files)
{
    Copy-Item "$Src\$f" "$Dst\$f"
}

Copy-Item "$Src\Evaluators\Aim\AgilityEvaluator.cs"  "$Dst\Evaluators\Aim\"
Copy-Item "$Src\Evaluators\Aim\FlowAimEvaluator.cs"  "$Dst\Evaluators\Aim\"
Copy-Item "$Src\Evaluators\Aim\SnapAimEvaluator.cs"  "$Dst\Evaluators\Aim\"
Copy-Item "$Src\Evaluators\FlashlightEvaluator.cs"   "$Dst\Evaluators\"
Copy-Item "$Src\Evaluators\ReadingEvaluator.cs"      "$Dst\Evaluators\"
Copy-Item "$Src\Evaluators\Speed\RhythmEvaluator.cs" "$Dst\Evaluators\Speed\"
Copy-Item "$Src\Evaluators\Speed\SpeedEvaluator.cs"  "$Dst\Evaluators\Speed\"
Copy-Item "$Src\Preprocessing\OsuDifficultyHitObject.cs" "$Dst\Preprocessing\"
Copy-Item "$Src\Skills\Aim.cs"         "$Dst\Skills\"
Copy-Item "$Src\Skills\Flashlight.cs"  "$Dst\Skills\"
Copy-Item "$Src\Skills\Reading.cs"     "$Dst\Skills\"
Copy-Item "$Src\Skills\Speed.cs"       "$Dst\Skills\"
Copy-Item "$Src\Utils\LegacyScoreUtils.cs" "$Dst\Utils\"

Get-ChildItem -Recurse -Filter "*.cs" $Dst | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $updated = $content -replace 'osu\.Game\.Rulesets\.Osu\.Difficulty', 'BaselineOsu.Difficulty'
    Set-Content $_.FullName $updated -NoNewline
}

$calcPath = "$Dst\OsuDifficultyCalculator.cs"
$content = Get-Content $calcPath -Raw
$updated = $content -replace 'using osu\.Game\.Beatmaps;', "using osu.Game.Beatmaps;`r`nusing osu.Game.Rulesets;"
Set-Content $calcPath $updated -NoNewline

$perfPath = "$Dst\OsuPerformanceCalculator.cs"
$content = Get-Content $perfPath -Raw
$updated = $content -replace 'using osu\.Game\.Rulesets\.Osu\.Scoring;', "using osu.Game.Rulesets.Osu;`r`nusing osu.Game.Rulesets.Osu.Scoring;"
Set-Content $perfPath $updated -NoNewline