cat > /sdcard/cpm.sh << 'SCRIPT'
#!/bin/bash
# =============================================
# JOZETH TOOLS CPM v3.2
# github.com/JOZETH-DEV/jozeth-dev-tools
# =============================================
R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;33m'; B='\033[1;34m'
M='\033[1;35m'; C='\033[1;36m'; W='\033[1;37m'; N='\033[0m'
API="https://bot-api.devwebasmodeo.workers.dev/api"
CHECK="https://bot-api.devwebasmodeo.workers.dev/validate"

loading() { echo -ne "${Y}[*] Procesando"; for i in {1..5}; do echo -ne "."; sleep 0.3; done; echo -e "${N}"; }

clear
echo -e "${R}╔══════════════════════════════════════════╗${N}"
echo -e "${R}║${Y}   ░░█▀█░█▀█░░█▀▀░▀█▀░█░█░░█▀▀░█▀█░█▀█░█▄█  ${R}║${N}"
echo -e "${R}║${Y}   ░░█░█░█░█░░▀▀█░░█░░█▀█░░▀▀█░█░█░█░█░█░█  ${R}║${N}"
echo -e "${R}║${Y}   ░░▀▀▀░▀▀▀░░▀▀▀░░▀░░▀░▀░░▀▀▀░▀▀▀░▀░▀░▀░▀  ${R}║${N}"
echo -e "${R}║${M}     JOZETH TOOLS CPM v3.2              ${R}║${N}"
echo -e "${R}║${W}   github.com/JOZETH-DEV/jozeth-dev-tools ${R}║${N}"
echo -e "${R}╚══════════════════════════════════════════╝${N}"
echo ""

read -p "🔑 Ingresa tu Key: " KEY
[ -z "$KEY" ] && { echo -e "${R}❌ Key requerida${N}"; exit 1; }

echo -e "${Y}📱 Verificando...${N}"
RESP=$(curl -s "$CHECK?key=$KEY")
VALID=$(echo "$RESP" | python3 -c "import sys,json;print(json.load(sys.stdin).get('valid'))" 2>/dev/null)
ERROR=$(echo "$RESP" | python3 -c "import sys,json;print(json.load(sys.stdin).get('error',''))" 2>/dev/null)

if [ "$VALID" != "True" ]; then
  echo -e "${R}╔══════════════════════════════════════════╗${N}"
  echo -e "${R}║  ❌ ACCESO DENEGADO                     ${R}║${N}"
  echo -e "${R}║  ${W}$ERROR${R}${N}"
  echo -e "${R}╚══════════════════════════════════════════╝${N}"
  exit 1
fi

echo -e "${G}✅ Acceso concedido${N}"
sleep 1
clear

echo -e "${R}╔══════════════════════════════════════════╗${N}"
echo -e "${R}║${Y}         INICIAR SESIÓN                  ${R}║${N}"
echo -e "${R}╚══════════════════════════════════════════╝${N}"
echo ""
echo -e "${C}🎮 Juego:${N}"
echo -e "  ${Y}[1]${W} 🚗 CPM1${N}"
echo -e "  ${Y}[2]${W} 🚗 CPM2${N}"
read -p "Opción: " GAME
case $GAME in 1) GNAME="CPM1";; 2) GNAME="CPM2";; *) echo -e "${R}❌ Inválido${N}"; exit 1;; esac

read -p "📧 Email: " EMAIL
read -sp "🔒 Password: " PASSWORD
echo ""
loading

LOGIN=$(curl -s -X POST "$API" -H "Content-Type: application/json" \
  -d "{\"action\":\"login\",\"game\":\"$GAME\",\"email\":\"$EMAIL\",\"password\":\"$PASSWORD\"}")
TOKEN=$(echo "$LOGIN" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))" 2>/dev/null)

[ -z "$TOKEN" ] && { echo -e "${R}❌ Error: Credenciales incorrectas${N}"; exit 1; }
echo -e "${G}✅ Sesión iniciada${N}"
sleep 1

while true; do
  clear
  echo -e "${R}╔══════════════════════════════════════════╗${N}"
  echo -e "${R}║${Y}            MENÚ PRINCIPAL               ${R}║${N}"
  echo -e "${R}║${M}   $GNAME - ${W}$EMAIL${R}${N}"
  echo -e "${R}╠══════════════════════════════════════════╣${N}"
  if [ "$GAME" = "1" ]; then
    echo -e "${R}║${Y} [1]${W} 👑 Activar Rango King              ${R}║${N}"
    echo -e "${R}║${Y} [2]${W} 📊 Ver Estadísticas                ${R}║${N}"
    echo -e "${R}║${Y} [3]${W} 🎁 Ver Recompensas                 ${R}║${N}"
    echo -e "${R}║${Y} [4]${W} 📋 Ver Tareas Diarias              ${R}║${N}"
  fi
  echo -e "${R}║${Y} [5]${W} 📧 Cambiar Email                   ${R}║${N}"
  echo -e "${R}║${Y} [6]${W} 🔒 Cambiar Contraseña              ${R}║${N}"
  echo -e "${R}║${Y} [7]${W} 🔄 Cerrar sesión                   ${R}║${N}"
  echo -e "${R}║${Y} [0]${W} 🚪 Salir                           ${R}║${N}"
  echo -e "${R}╚══════════════════════════════════════════╝${N}"
  read -p "Opción: " OPT

  case $OPT in
    1) [ "$GAME" = "1" ] && { loading; curl -s -X POST "$API" -d "{\"action\":\"king\",\"token\":\"$TOKEN\"}" > /dev/null; echo -e "${G}✅ King Activado${N}"; read -p "Enter..."; } ;;
    2) [ "$GAME" = "1" ] && { loading; curl -s -X POST "$API" -d "{\"action\":\"status\",\"token\":\"$TOKEN\"}" | python3 -c "import sys,json;d=json.load(sys.stdin);r=json.loads(d.get('result','{}'));l=r.get('level',0);print(f'🏆 Nivel:{l} | 👑 King:{\"SI ✅\" if l>=6 else \"NO ❌\"} | ⚠️ Reportes:{r.get(\"reports\",\"?\")}')"; read -p "Enter..."; } ;;
    3) [ "$GAME" = "1" ] && { loading; curl -s -X POST "$API" -d "{\"action\":\"rewards\",\"token\":\"$TOKEN\"}" | python3 -c "import sys,json;d=json.load(sys.stdin);r=json.loads(d.get('result','[]'));[print(f'Día {i+1}: {\"✅\" if x.get(\"status\")==1 else \"⬜\"} Cash:{x.get(\"cash\",0)} Coin:{x.get(\"coin\",0)}') for i,x in enumerate(r)]"; read -p "Enter..."; } ;;
    4) [ "$GAME" = "1" ] && { loading; curl -s -X POST "$API" -d "{\"action\":\"tasks\",\"token\":\"$TOKEN\"}" | python3 -c "import sys,json;d=json.load(sys.stdin);r=json.loads(d.get('result','{}'));[print(f'{t.get(\"name\")}: {t.get(\"current\")}/{t.get(\"goal\")}') for t in r.get('tasks',[])]"; read -p "Enter..."; } ;;
    5) read -p "📧 Nuevo Email: " NEWEMAIL; loading; RES=$(curl -s -X POST "$API" -d "{\"action\":\"change_email\",\"token\":\"$TOKEN\",\"newEmail\":\"$NEWEMAIL\",\"password\":\"$PASSWORD\",\"game\":\"$GAME\"}"); NEWTOKEN=$(echo "$RES" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))"); [ -n "$NEWTOKEN" ] && { TOKEN="$NEWTOKEN"; EMAIL="$NEWEMAIL"; echo -e "${G}✅ Email cambiado${N}"; } || echo -e "${R}❌ Error${N}"; read -p "Enter..."; ;;
    6) read -sp "🔒 Nueva Contraseña: " NEWPASS; echo ""; loading; RES=$(curl -s -X POST "$API" -d "{\"action\":\"change_password\",\"token\":\"$TOKEN\",\"newPass\":\"$NEWPASS\",\"email\":\"$EMAIL\",\"game\":\"$GAME\"}"); NEWTOKEN=$(echo "$RES" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))"); [ -n "$NEWTOKEN" ] && { TOKEN="$NEWTOKEN"; PASSWORD="$NEWPASS"; echo -e "${G}✅ Contraseña cambiada${N}"; } || echo -e "${R}❌ Error${N}"; read -p "Enter..."; ;;
    7) exec bash "$0" ;;
    0) echo -e "${R}👋 ¡Hasta luego!${N}"; exit 0 ;;
  esac
done
SCRIPT

chmod +x /sdcard/cpm.sh
