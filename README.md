# Patch Busca Inteligente - 2026-07-22

Este pacote corrige o monitor de trafego do addon `busca_inteligente` e pode ser usado tambem em `busca_rapida`.

## O que o patch corrige

- adiciona `config_busca.php` quando ele nao existe
- corrige `api/routeros_api.class.php` para carregar `config_busca.php` com `__DIR__`
- corrige `api/winbox.php` para funcionar mesmo quando a coluna `userapi` nao existir no cadastro do NAS
- adiciona mensagem clara de erro quando nao houver conexao com a API do roteador
- exibe esse erro na tela do monitor em vez de deixar o grafico vazio

## Estrutura esperada no servidor

```text
/opt/mk-auth/admin/addons/busca_inteligente
/opt/mk-auth/admin/addons/busca_rapida
```

## Como aplicar no servidor

1. Envie a pasta do patch para o servidor.
2. Entre na pasta enviada.
3. Execute:

```bash
chmod +x apply_patch_busca.sh
./apply_patch_busca.sh busca_inteligente
```

Para `busca_rapida`:

```bash
./apply_patch_busca.sh busca_rapida
```

Se o base path do MK-AUTH for diferente:

```bash
./apply_patch_busca.sh busca_inteligente /caminho/base/dos/addons
```

## Backup

O script cria backup automatico antes de sobrescrever:

```text
/opt/mk-auth/admin/addons/busca_inteligente.backup-codex-YYYYMMDD_HHMMSS
```
