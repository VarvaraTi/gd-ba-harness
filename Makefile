.PHONY: build validate test

SKILL := skills/gd-ba-harness/SKILL.md
DIST := dist/gd-ba-harness.skill

validate:
	@test -f "$(SKILL)"
	@rg -q '^name: gd-ba-harness$$' "$(SKILL)"
	@rg -q '^description: ".+"$$' "$(SKILL)"
	@rg -q '^disable-model-invocation: true$$' "$(SKILL)"
	@! rg -q 'gd-requirements' skills/gd-ba-harness
	@rg -q 'MUST READ `assets/requirements-lite.md`' "$(SKILL)"
	@rg -q 'MUST READ `assets/knowledge-organization.md`' "$(SKILL)"
	@rg -q 'mode: read-only' skills/gd-ba-harness/templates/project-profile.yaml
	@echo "Skill metadata and standalone contract are valid."

test: validate
	@rg -q '^schema_version: 1$$' skills/gd-ba-harness/templates/project-profile.yaml
	@test "$$(rg -c '^  - (INITIAL|UPDATE|VALIDATE)$$' skills/gd-ba-harness/templates/project-profile.yaml)" = "3"
	@! rg -q '^  - (QUERY|REVERSE|REFACTOR)$$' skills/gd-ba-harness/templates/project-profile.yaml
	@rg -q '^mode: INITIAL$$' skills/gd-ba-harness/templates/run-manifest.yaml
	@rg -q '^read_only: false$$' skills/gd-ba-harness/templates/run-manifest.yaml
	@rg -q '^  max_sources: 5$$' skills/gd-ba-harness/templates/run-manifest.yaml
	@rg -q '^  max_source_lines: 10000$$' skills/gd-ba-harness/templates/run-manifest.yaml
	@rg -q '^  max_question_rounds: 2$$' skills/gd-ba-harness/templates/run-manifest.yaml
	@rg -q '^  max_requirements_per_batch: 15$$' skills/gd-ba-harness/templates/run-manifest.yaml
	@rg -q '^on_limit_exceeded: stop-and-propose-split$$' skills/gd-ba-harness/templates/run-manifest.yaml
	@rg -q 'requirement-set hashes are unchanged' skills/gd-ba-harness/assets/validate.md
	@rg -qi 'do not perform an exhaustive standards sweep' skills/gd-ba-harness/assets/requirements-lite.md
	@rg -q '^  strategy: minimal' skills/gd-ba-harness/templates/project-profile.yaml
	@rg -q '^  max_in_progress_features: 1$$' skills/gd-ba-harness/templates/project-profile.yaml
	@rg -q '^  immutable_feature_spec: true$$' skills/gd-ba-harness/templates/project-profile.yaml
	@rg -q '^feature_id:' skills/gd-ba-harness/templates/FEATURE.md
	@rg -q 'Derived from `features/\*/FEATURE.md`' skills/gd-ba-harness/templates/FEATURE-INDEX.md
	@rg -q 'Duplicate feature gate' skills/gd-ba-harness/assets/knowledge-organization.md
	@rg -q 'sole authoritative feature specification' skills/gd-ba-harness/assets/requirements-lite.md
	@rg -q 'scratch/' skills/gd-ba-harness/assets/knowledge-organization.md
	@test "$$(rg -l '^# ' tests/fixtures/*.md | wc -l | tr -d ' ')" = "8"
	@echo "Templates, budgets, knowledge strategies, and fixtures are valid."

build: test
	@rm -rf dist
	@mkdir -p dist/package
	@cp -R skills/gd-ba-harness dist/package/gd-ba-harness
	@cd dist/package && zip -qr ../gd-ba-harness.skill gd-ba-harness
	@rm -rf dist/package
	@test "$$(unzip -Z1 "$(DIST)" | awk -F/ 'NF {print $$1}' | sort -u | wc -l | tr -d ' ')" = "1"
	@unzip -Z1 "$(DIST)" | rg -qx 'gd-ba-harness/SKILL.md'
	@! unzip -p "$(DIST)" | rg -q 'gd-requirements'
	@echo "Built $(DIST)"
