# === set your repo path ===
REPO="/mnt/c/Users/Main Computer/Documents/PromptsLibrary"

# 1) go to the repo
cd "$REPO" || { echo "Path not found: $REPO"; exit 1; }

# 2) create the Meta Tokens structure
mkdir -p "Meta Tokens"/{01_Concepts,02_Prompts,03_References,99_Archive}

# 3) seed README so Git tracks the folder
cat > "Meta Tokens/README.md" <<'EOF'
# Meta Tokens

Purpose: Store prompts, notes, and references related to Meta/“token” concepts (naming, distribution, tokenomics, standards, glossaries).

## Folder Structure
- 01_Concepts — Definitions, theoretical notes
- 02_Prompts — Actual working prompt files
- 03_References — External docs or snippets
- 99_Archive — Old/deprecated materials

## Conventions
- Keep filenames short and meaningful
- Prefix with YYYY-MM-DD when date-relevant
