#!/bin/sh
set -eu

ADDON_NAME="${1:-busca_inteligente}"
BASE_DIR="${2:-/opt/mk-auth/admin/addons}"
TARGET_DIR="${BASE_DIR}/${ADDON_NAME}"
PATCH_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
BACKUP_DIR="${TARGET_DIR}.backup-codex-$(date +%Y%m%d_%H%M%S)"

echo "Addon alvo: ${TARGET_DIR}"

if [ ! -d "${TARGET_DIR}" ]; then
  echo "ERRO: diretÃ³rio do addon nÃ£o encontrado: ${TARGET_DIR}" >&2
  exit 1
fi

for required in \
  "${TARGET_DIR}/monitor_traffic.php" \
  "${TARGET_DIR}/api/winbox.php" \
  "${TARGET_DIR}/api/routeros_api.class.php"
do
  if [ ! -f "${required}" ]; then
    echo "ERRO: arquivo obrigatÃ³rio nÃ£o encontrado: ${required}" >&2
    exit 1
  fi
done

mkdir -p "${BACKUP_DIR}/api"
cp -a "${TARGET_DIR}/monitor_traffic.php" "${BACKUP_DIR}/monitor_traffic.php"
cp -a "${TARGET_DIR}/config_busca.php" "${BACKUP_DIR}/config_busca.php" 2>/dev/null || true
cp -a "${TARGET_DIR}/api/winbox.php" "${BACKUP_DIR}/api/winbox.php"
cp -a "${TARGET_DIR}/api/routeros_api.class.php" "${BACKUP_DIR}/api/routeros_api.class.php"

install -m 0644 "${PATCH_DIR}/config_busca.php" "${TARGET_DIR}/config_busca.php"
install -m 0644 "${PATCH_DIR}/monitor_traffic.php" "${TARGET_DIR}/monitor_traffic.php"
install -m 0644 "${PATCH_DIR}/api/winbox.php" "${TARGET_DIR}/api/winbox.php"
install -m 0644 "${PATCH_DIR}/api/routeros_api.class.php" "${TARGET_DIR}/api/routeros_api.class.php"

if command -v php >/dev/null 2>&1; then
  php -l "${TARGET_DIR}/config_busca.php"
  php -l "${TARGET_DIR}/monitor_traffic.php"
  php -l "${TARGET_DIR}/api/winbox.php"
  php -l "${TARGET_DIR}/api/routeros_api.class.php"
fi

echo "Patch aplicado com sucesso."
echo "Backup salvo em: ${BACKUP_DIR}"
