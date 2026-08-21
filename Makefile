.PHONY: build validate test

SKILL_DIR := plugins/gd-ba-harness/skills/gd-ba-harness
SKILL := $(SKILL_DIR)/SKILL.md
DIST := dist/gd-ba-harness.skill

validate:
	@test -f "$(SKILL)"
	@rg -q '^name: gd-ba-harness$$' "$(SKILL)"
	@rg -q '^description: ".+"$$' "$(SKILL)"
	@rg -q '^disable-model-invocation: true$$' "$(SKILL)"
	@! rg -q 'gd-requirements' "$(SKILL_DIR)"
	@rg -q 'MUST READ `assets/requirements-lite.md`' "$(SKILL)"
	@rg -q 'MUST READ `assets/knowledge-organization.md`' "$(SKILL)"
	@rg -q 'mode: read-only' "$(SKILL_DIR)/templates/project-profile.yaml"
	@echo "Skill metadata and standalone contract are valid."

test: validate
	@rg -q '^schema_version: 1$$' "$(SKILL_DIR)/templates/project-profile.yaml"
	@test "$$(rg -c '^  - (INITIAL|UPDATE|VALIDATE)$$' "$(SKILL_DIR)/templates/project-profile.yaml")" = "3"
	@! rg -q '^  - (QUERY|REVERSE|REFACTOR)$$' "$(SKILL_DIR)/templates/project-profile.yaml"
	@rg -q '^mode: INITIAL$$' "$(SKILL_DIR)/templates/run-manifest.yaml"
	@rg -q '^read_only: false$$' "$(SKILL_DIR)/templates/run-manifest.yaml"
	@rg -q '^  max_sources: 5$$' "$(SKILL_DIR)/templates/run-manifest.yaml"
	@rg -q '^  max_source_lines: 10000$$' "$(SKILL_DIR)/templates/run-manifest.yaml"
	@rg -q '^  max_question_rounds: 2$$' "$(SKILL_DIR)/templates/run-manifest.yaml"
	@rg -q '^  max_requirements_per_batch: 15$$' "$(SKILL_DIR)/templates/run-manifest.yaml"
	@rg -q '^on_limit_exceeded: stop-and-propose-split$$' "$(SKILL_DIR)/templates/run-manifest.yaml"
	@rg -q 'requirement-set hashes are unchanged' "$(SKILL_DIR)/assets/validate.md"
	@rg -qi 'do not perform an exhaustive standards sweep' "$(SKILL_DIR)/assets/requirements-lite.md"
	@rg -q '^  strategy: minimal' "$(SKILL_DIR)/templates/project-profile.yaml"
	@rg -q '^  max_in_progress_features: 1$$' "$(SKILL_DIR)/templates/project-profile.yaml"
	@rg -q '^  immutable_feature_spec: true$$' "$(SKILL_DIR)/templates/project-profile.yaml"
	@rg -q '^feature_id:' "$(SKILL_DIR)/templates/FEATURE.md"
	@rg -q 'Derived from `features/\*/FEATURE.md`' "$(SKILL_DIR)/templates/FEATURE-INDEX.md"
	@rg -q 'Duplicate feature gate' "$(SKILL_DIR)/assets/knowledge-organization.md"
	@rg -q 'sole authoritative feature specification' "$(SKILL_DIR)/assets/requirements-lite.md"
	@rg -q 'scratch/' "$(SKILL_DIR)/assets/knowledge-organization.md"
	@test "$$(rg -l '^# ' tests/fixtures/*.md | wc -l | tr -d ' ')" = "8"
	@echo "Templates, budgets, knowledge strategies, and fixtures are valid."

build: test
	@rm -rf dist
	@mkdir -p dist/package
	@cp -R "$(SKILL_DIR)" dist/package/gd-ba-harness
	@cd dist/package && zip -qr ../gd-ba-harness.skill gd-ba-harness
	@rm -rf dist/package
	@test "$$(unzip -Z1 "$(DIST)" | awk -F/ 'NF {print $$1}' | sort -u | wc -l | tr -d ' ')" = "1"
	@unzip -Z1 "$(DIST)" | rg -qx 'gd-ba-harness/SKILL.md'
	@! unzip -p "$(DIST)" | rg -q 'gd-requirements'
	@echo "Built $(DIST)"
