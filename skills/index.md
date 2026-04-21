# Skills Index

| Skill | Description | Version |
|-------|-------------|---------|
| `dockerized` | Generic Docker-first development | 1.0.0 |
| `agentic-python` | Python agents (extends dockerized) | 26.04 |

## Adding a New Skill

1. Create `skills/<skill-name>/SKILL.md`
2. Include frontmatter with name, description, compatibility:
   ```yaml
   ---
   name: <skill-name>
   description: What this skill does
   compatibility: [claude-code, opencode, kilo]
   metadata:
     version: "1.0.0"
     author: your-github
   ---
   ```
3. Run `./install.sh --tool <tool> --skill <skill-name>`