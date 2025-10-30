# File: UltraRealismPromptor.ps1
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Subject,
    [int]$TriggersCount = 2,
    [int]$CamerasCount  = 2,
    [string]$AspectRatio = "16:9",
    [string]$Quality     = "5",
    [string]$Version     = "6.1",
    [string]$OutFile
)

function Get-RandomItems {
    param([object[]]$Array,[int]$Count)
    if ($Count -gt $Array.Count) { $Count = $Array.Count }
    $Array | Get-Random -Count $Count
}

$RealismTriggers = @(
    "the most photorealistic image in the world",
    "the most realistic photograph ever captured",
    "award-winning documentary photograph",
    "hyper-detailed IMAX film still",
    "Hasselblad X2D Vogue cover photo",
    "uncompressed RAW 16bit ACEScg image",
    "lost film archive still, ultra-photoreal",
    "deleted production still from a Hollywood movie",
    "PhaseOne IQ4 medium format capture",
    "ProRes_4444XQ, 8K HDRi, zero noise"
)

$CameraPairs = @(
    "ARRI Alexa 65 + Panavision T-series anamorphic",
    "RED V-RAPTOR 8K VistaVision",
    "Sony Venice 2 IMAX certified",
    "Hasselblad X2D + 80mm f/1.9",
    "PhaseOne IQ4 150MP + Schneider Kreuznach 80mm LS f/2.8",
    "Leica SL2-S + Summilux 35mm f/1.4"
)

$LightingOptions = @(
    "Golden hour rim light, volumetric fog, HDR10+",
    "Beauty dish portrait lighting, polarized reflections",
    "Neon city glow, cinematic falloff, halation_glow2024",
    "Soft diffusion, high contrast film grain 35mm"
)

$chosenTriggers = Get-RandomItems $RealismTriggers $TriggersCount
$chosenCameras  = Get-RandomItems $CameraPairs  $CamerasCount
$chosenLighting = Get-RandomItems $LightingOptions 1

$imperfections = @(
    "natural imperfections","micro-scratches","subtle dust motes",
    "fine skin texture","lens breathing","chromatic aberration"
) | Get-Random -Count 2

$final = ("{0}, {1}, {2}, {3}, cinematic depth of field, " +
          "ultra-detailed textures, RAW colour science, hyper-realistic, " +
          "shot on location, {4} —ar {5} —q {6} —v {7}") -f `
          $Subject,
          ($chosenTriggers -join ", "),
          ($chosenCameras  -join ", "),
          $chosenLighting[0],
          ($imperfections  -join ", "),
          $AspectRatio, $Quality, $Version

if ($OutFile) {
    $dir = Split-Path -Parent $OutFile
    if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
    $final | Out-File -FilePath $OutFile -Encoding UTF8
    Write-Host "Saved prompt to: $OutFile"
} else {
    # Also copy to clipboard for convenience
    $final | Set-Clipboard
    Write-Output $final
    Write-Host "`n(Copied to clipboard)"
}