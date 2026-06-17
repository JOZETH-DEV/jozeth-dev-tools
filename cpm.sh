cat > $PREFIX/bin/cpm << 'SCRIPT'
#!/bin/bash
# =============================================
# JOZETH TOOLS CPM v4.0 - RAINBOW EDITION
# github.com/JOZETH-DEV/jozeth-dev-tools
# =============================================

# === COLORES ===
R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;33m'; B='\033[1;34m'
M='\033[1;35m'; C='\033[1;36m'; W='\033[1;37m'; N='\033[0m'
RD='\033[0;31m'; GD='\033[0;32m'; YD='\033[0;33m'; BD='\033[0;34m'
MD='\033[0;35m'; CD='\033[0;36m'

# === API ===
API="https://bot-api.devwebasmodeo.workers.dev/api"
CHECK="https://bot-api.devwebasmodeo.workers.dev/validate"

# === FUNCIONES ===
loading() {
  echo -ne "${Y}⟳"
  for i in {1..5}; do
    echo -ne "${R}█${G}█${B}█${M}█${C}█"
    sleep 0.2
  done
  echo -e "${N}"
}

rainbow_input() {
  local prompt="$1"
  local var="$2"
  echo -ne "${R}║${N} ${M}$prompt${N}"
  read "$var"
}

rainbow_pass() {
  local prompt="$1"
  local var="$2"
  echo -ne "${R}║${N} ${M}$prompt${N}"
  read -s "$var"
  echo ""
}

# === BANNER RAINBOW ===
clear
echo -e "${R}╔══════════════════════════════════════════╗"
echo -e "${G}║  ░░█▀█░█▀█░░█▀▀░▀█▀░█░█░░█▀▀░█▀█░█▀█░█▄█  ║"
echo -e "${B}║  ░░█░█░█░█░░▀▀█░░█░░█▀█░░▀▀█░█░█░█░█░█░█  ║"
echo -e "${M}║  ░░▀▀▀░▀▀▀░░▀▀▀░░▀░░▀░▀░░▀▀▀░▀▀▀░▀░▀░▀░▀  ║"
echo -e "${C}║                                            ║"
echo -e "${Y}║     JOZETH TOOLS CPM v4.0                 ║"
echo -e "${W}║   github.com/JOZETH-DEV/jozeth-dev-tools   ║"
echo -e "${R}╚══════════════════════════════════════════╝${N}"
echo ""

# === VALIDAR KEY ===
echo -e "${C}┌─ ${W}🔐 SISTEMA DE ACCESO${N}"
echo -e "${C}└─ ${W}Obtén tu Key: @CPM_Tool_Bot en Telegram${N}"
echo ""
echo -ne "${R}║${N} ${Y}🔑 Ingresa tu Key: ${N}"
read KEY

if [ -z "$KEY" ] || [ ${#KEY} -lt 8 ]; then
  echo -e "${R}╔══════════════════════════════════════════╗"
  echo -e "${R}║  ❌ ACCESO DENEGADO - Key inválida      ║"
  echo -e "${R}╚══════════════════════════════════════════╝${N}"
  exit 1
fi

echo -e "${C}┌─ ${Y}📱 Verificando identidad...${N}"
loading

RESP=$(curl -s "$CHECK?key=$KEY")
VALID=$(echo "$RESP" | python3 -c "import sys,json;print(json.load(sys.stdin).get('valid'))" 2>/dev/null)
ERROR=$(echo "$RESP" | python3 -c "import sys,json;print(json.load(sys.stdin).get('error',''))" 2>/dev/null)

if [ "$VALID" != "True" ]; then
  echo -e "${R}╔══════════════════════════════════════════╗"
  echo -e "${R}║  ❌ ACCESO DENEGADO                     ║"
  echo -e "${R}║  ${W}$ERROR${R}${N}"
  echo -e "${R}╚══════════════════════════════════════════╝${N}"
  exit 1
fi

echo -e "${C}└─ ${G}✅ Acceso concedido - Bienvenido${N}"
sleep 1
clear

# === LOGIN ===
echo -e "${R}╔══════════════════════════════════════════╗"
echo -e "${Y}║         🔐 INICIAR SESIÓN               ║"
echo -e "${R}╚══════════════════════════════════════════╝${N}"
echo ""

echo -e "${C}┌─ ${W}🎮 Selecciona el juego:${N}"
echo -e "${B}├─ ${Y}[1]${W} 🚗 CPM1 - Car Parking Multiplayer${N}"
echo -e "${B}├─ ${Y}[2]${W} 🚗 CPM2 - Car Parking Multiplayer 2${N}"
echo -ne "${B}└─ ${M}Opción: ${N}"
read GAME

case $GAME in
  1) GNAME="CPM1";;
  2) GNAME="CPM2";;
  *) echo -e "${R}❌ Inválido${N}"; exit 1;;
esac

echo ""
echo -ne "${R}║${N} ${Y}📧 Email: ${N}"
read EMAIL
echo -ne "${R}║${N} ${Y}🔒 Password: ${N}"
read -s PASSWORD
echo ""

echo -e "${C}┌─ ${Y}Iniciando sesión...${N}"
loading

LOGIN=$(curl -s -X POST "$API" -H "Content-Type: application/json" \
  -d "{\"action\":\"login\",\"game\":\"$GAME\",\"email\":\"$EMAIL\",\"password\":\"$PASSWORD\"}")

TOKEN=$(echo "$LOGIN" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))" 2>/dev/null)

if [ -z "$TOKEN" ]; then
  echo -e "${R}└─ ❌ Error: Credenciales incorrectas${N}"
  exit 1
fi

echo -e "${C}└─ ${G}✅ Sesión iniciada correctamente${N}"
sleep 1

# === MENÚ PRINCIPAL ===
while true; do
  clear
  echo -e "${R}╔══════════════════════════════════════════╗"
  echo -e "${Y}║            MENÚ PRINCIPAL               ║"
  echo -e "${G}║   ${W}$GNAME${G} - ${W}$EMAIL${G}${N}"
  echo -e "${R}╠══════════════════════════════════════════╣"
  
  if [ "$GAME" = "1" ]; then
    echo -e "${R}║${N} ${Y}[1]${W} 👑 Activar Rango King              ${R}║${N}"
    echo -e "${R}║${N} ${Y}[2]${W} 📊 Ver Estadísticas                ${R}║${N}"
    echo -e "${R}║${N} ${Y}[3]${W} 🎁 Ver Recompensas                 ${R}║${N}"
    echo -e "${R}║${N} ${Y}[4]${W} 📋 Ver Tareas Diarias              ${R}║${N}"
  fi
  echo -e "${R}║${N} ${Y}[5]${W} 📧 Cambiar Email                   ${R}║${N}"
  echo -e "${R}║${N} ${Y}[6]${W} 🔒 Cambiar Contraseña              ${R}║${N}"
  echo -e "${R}║${N} ${Y}[7]${W} 🔄 Cerrar sesión                   ${R}║${N}"
  echo -e "${R}║${N} ${Y}[0]${W} 🚪 Salir                           ${R}║${N}"
  echo -e "${R}╚══════════════════════════════════════════╝${N}"
  echo ""
  echo -ne "${M}┌─ ${W}Selecciona una opción: ${N}"
  read OPT
  echo ""

  case $OPT in
    1)
      if [ "$GAME" = "1" ]; then
        clear
        echo -e "${Y}╔══════════════════════════════════════════╗"
        echo -e "${Y}║         👑 ACTIVAR RANGO KING            ║"
        echo -e "${Y}╚══════════════════════════════════════════╝${N}"
        loading
        curl -s -X POST "$API" -H "Content-Type: application/json" \
          -d "{\"action\":\"king\",\"token\":\"$TOKEN\"}" > /dev/null
        echo -e "${G}╔══════════════════════════════════════════╗"
        echo -e "${G}║  ✅ RANGO KING ACTIVADO                 ║"
        echo -e "${G}║  📲 Entra al juego para ver cambios     ║"
        echo -e "${G}╚══════════════════════════════════════════╝${N}"
        read -p "Enter para continuar..."
      fi
      ;;
    2)
      if [ "$GAME" = "1" ]; then
        clear
        echo -e "${B}╔══════════════════════════════════════════╗"
        echo -e "${B}║         📊 ESTADÍSTICAS                  ║"
        echo -e "${B}╚══════════════════════════════════════════╝${N}"
        loading
        curl -s -X POST "$API" -H "Content-Type: application/json" \
          -d "{\"action\":\"status\",\"token\":\"$TOKEN\"}" | python3 -c "
import sys,json
d=json.load(sys.stdin)
r=json.loads(d.get('result','{}'))
l=r.get('level',0)
print(f'  🏆 Nivel: {l}')
print(f'  👑 Rango: {\"KING ✅\" if l>=6 else \"Normal ❌\"}')
print(f'  ⚠️  Reportes: {r.get(\"reports\",\"?\")}')
print(f'  🟢 Puede Jugar: {\"SI ✅\" if r.get(\"canPlay\")==1 else \"NO ❌\"}')
"
        read -p "Enter para continuar..."
      fi
      ;;
    3)
      if [ "$GAME" = "1" ]; then
        clear
        echo -e "${C}╔══════════════════════════════════════════╗"
        echo -e "${C}║         🎁 RECOMPENSAS DIARIAS           ║"
        echo -e "${C}╚══════════════════════════════════════════╝${N}"
        loading
        curl -s -X POST "$API" -H "Content-Type: application/json" \
          -d "{\"action\":\"rewards\",\"token\":\"$TOKEN\"}" | python3 -c "
import sys,json
d=json.load(sys.stdin)
r=json.loads(d.get('result','[]'))
tc=0;tm=0
for i,x in enumerate(r):
    s='✅' if x.get('status')==1 else '⬜'
    c=x.get('cash',0); m=x.get('coin',0); ca=x.get('car',0)
    extra=f' | 🚗 Auto:{ca}' if ca>0 else ''
    print(f'  Día {i+1}: {s} | 💵{c} | 🪙{m}{extra}')
    tc+=c; tm+=m
print(f'  ────────────────────────')
print(f'  💰 TOTAL: {tc} Cash | 🪙 {tm} Coins')
"
        read -p "Enter para continuar..."
      fi
      ;;
    4)
      if [ "$GAME" = "1" ]; then
        clear
        echo -e "${M}╔══════════════════════════════════════════╗"
        echo -e "${M}║         📋 TAREAS DIARIAS                ║"
        echo -e "${M}╚══════════════════════════════════════════╝${N}"
        loading
        curl -s -X POST "$API" -H "Content-Type: application/json" \
          -d "{\"action\":\"tasks\",\"token\":\"$TOKEN\"}" | python3 -c "
import sys,json
d=json.load(sys.stdin)
r=json.loads(d.get('result','{}'))
for t in r.get('tasks',[]):
    p=t.get('prize',{})
    print(f'  📌 {t.get(\"name\")}: {t.get(\"current\")}/{t.get(\"goal\")}')
    print(f'     💰 {p.get(\"cash\",0)} Cash | 🪙 {p.get(\"coin\",0)} Coins')
"
        read -p "Enter para continuar..."
      fi
      ;;
    5)
      clear
      echo -e "${W}╔══════════════════════════════════════════╗"
      echo -e "${W}║         📧 CAMBIAR EMAIL                 ║"
      echo -e "${W}╚══════════════════════════════════════════╝${N}"
      echo -ne "${R}║${N} ${Y}📧 Nuevo Email: ${N}"
      read NEWEMAIL
      loading
      RES=$(curl -s -X POST "$API" -H "Content-Type: application/json" \
        -d "{\"action\":\"change_email\",\"token\":\"$TOKEN\",\"newEmail\":\"$NEWEMAIL\",\"password\":\"$PASSWORD\",\"game\":\"$GAME\"}")
      NEWTOKEN=$(echo "$RES" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))" 2>/dev/null)
      if [ -n "$NEWTOKEN" ]; then
        TOKEN="$NEWTOKEN"; EMAIL="$NEWEMAIL"
        echo -e "${G}✅ Email cambiado exitosamente${N}"
      else
        echo -e "${R}❌ Error al cambiar email${N}"
      fi
      read -p "Enter para continuar..."
      ;;
    6)
      clear
      echo -e "${W}╔══════════════════════════════════════════╗"
      echo -e "${W}║         🔒 CAMBIAR CONTRASEÑA            ║"
      echo -e "${W}╚══════════════════════════════════════════╝${N}"
      echo -ne "${R}║${N} ${Y}🔒 Nueva Contraseña: ${N}"
      read -s NEWPASS
      echo ""
      loading
      RES=$(curl -s -X POST "$API" -H "Content-Type: application/json" \
        -d "{\"action\":\"change_password\",\"token\":\"$TOKEN\",\"newPass\":\"$NEWPASS\",\"email\":\"$EMAIL\",\"game\":\"$GAME\"}")
      NEWTOKEN=$(echo "$RES" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))" 2>/dev/null)
      if [ -n "$NEWTOKEN" ]; then
        TOKEN="$NEWTOKEN"; PASSWORD="$NEWPASS"
        echo -e "${G}✅ Contraseña cambiada exitosamente${N}"
      else
        echo -e "${R}❌ Error al cambiar contraseña${N}"
      fi
      read -p "Enter para continuar..."
      ;;
    7)
      exec bash "$0"
      ;;
    0)
      clear
      echo -e "${R}╔══════════════════════════════════════════╗"
      echo -e "${R}║     👋 ¡HASTA LUEGO!                    ║"
      echo -e "${R}║  JOZETH TOOLS CPM - Rainbow Edition     ║"
      echo -e "${R}╚══════════════════════════════════════════╝${N}"
      exit 0
      ;;
    *)
      echo -e "${R}❌ Opción inválida${N}"
      sleep 1
      ;;
  esac
done
SCRIPT

chmod +x $PREFIX/bin/cpm
