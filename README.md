# OrangeHRM Robot Test Suite

Automação de testes web do OrangeHRM utilizando Robot Framework e Robot Framework Browser (Playwright).

## Estrutura

- `robot/variables/vars.robot`: variáveis padrão (podem ser sobrescritas via ambiente/CLI)
- `robot/resources/common/`: keywords comuns com waits, setup/teardown
- `robot/resources/locators/`: seletores agrupados por parte da tela (Login, Admin)
- `robot/resources/pages/`: Page Objects com Given/When/Then
- `robot/tests/`: suítes de teste (`AdminTests.robot`, `AdminUserCRUD.robot`)

### Sobrescrever via CLI

```bash
robot \
  --variable BASE_URL:https://example \
  --variable ADMIN_USER:MyUser \
  --variable ADMIN_PASS:MyPass \
  --variable HEADLESS:True \
  -d robot/reports robot/tests
```

## Execução Local

1. Python virtualenv e dependências:
```bash
python -m venv .venv
.venv/Scripts/python -m pip install --upgrade pip
.venv/Scripts/pip install robotframework robotframework-browser
.venv/Scripts/rfbrowser init
```
2. Rodar testes:
```bash
.venv/Scripts/robot -d robot/reports robot/tests
```

## Docker

### Build
```bash
docker build -t orangehrm-robot .
```

### Run
```bash
docker run --rm \
  -e BASE_URL=https://opensource-demo.orangehrmlive.com/web/index.php/auth/login \
  -e ADMIN_USER=Admin -e ADMIN_PASS=admin123 -e HEADLESS=True \
  orangehrm-robot
```

## GitHub Actions

Workflow em `.github/workflows/robot-ci.yml` com variáveis de ambiente:

- Editáveis no bloco `env:`
- Execução dos testes com `--variable` para mapear os valores do ambiente

## Boas Práticas Aplicadas

- Page Object + locators por seção
- Esperas dinâmicas em todas as interações
- Teardown com evidência em falhas
- Tags e documentação por caso de teste

## Suítes

- `AdminTests.robot`: validações de UI e mensagens
- `AdminUserCRUD.robot`: criação, edição e remoção de usuário

## Notas

- Credenciais padrão do OrangeHRM: usuário `Admin`, senha `admin123`
