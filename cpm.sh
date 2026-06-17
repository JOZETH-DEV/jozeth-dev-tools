cat > /sdcard/cpm.sh << 'SCRIPT'
#!/bin/bash
# =============================================
# JOZETH TOOLS CPM v3.0
# By @Asmodeo | github.com/JOZETH-DEV
# =============================================

# === COLORES ===
R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;33m'; B='\033[1;34m'
M='\033[1;35m'; C='\033[1;36m'; W='\033[1;37m'; N='\033[0m'
D='\033[2m'

# === API (OCULTA) ===
API="https://bot-api.devwebasmodeo.workers.dev/api"
CHECK="https://bot-api.devwebasmodeo.workers.dev/validate"

# === FUNCIONES ===
loading() {
  echo -ne "${Y}[*] Procesando"
  for i in {1..5}; do echo -ne "."; sleep 0.3; done
  echo -e "${N}"
}

# === BANNER ===
clear
echo -e "${R}╔══════════════════════════════════════════╗${N}"
echo -e "${R}║${Y}   ░░█▀█░█▀█░░█▀▀░▀█▀░█░█░░█▀▀░█▀█░█▀█░█▄█  ${R}║${N}"
echo -e "${R}║${Y}   ░░█░█░█░█░░▀▀█░░█░░█▀█░░▀▀█░█░█░█░█░█░█  ${R}║${N}"
echo -e "${R}║${Y}   ░░▀▀▀░▀▀▀░░▀▀▀░░▀░░▀░▀░░▀▀▀░▀▀▀░▀░▀░▀░▀  ${R}║${N}"
echo -e "${R}║${M}     JOZETH TOOLS CPM v3.0              ${R}║${N}"
echo -e "${R}║${W}   github.com/JOZETH-DEV/jozeth-dev-tools ${R}║${N}"
echo -e "${R}╚══════════════════════════════════════════╝${N}"
echo ""

# === VALIDAR KEY ===
echo -e "${C}🔐 SISTEMA DE ACCESO${N}"
echo -e "${D}Obtén tu Key: @CPM_Tool_Bot en Telegram${N}"
echo ""
read -p "🔑 Ingresa tu Key: " KEY

if [ -z "$KEY" ] || [ ${#KEY} -lt 10 ]; then
  echo -e "${R}╔══════════════════════════════════════════╗${N}"
  echo -e "${R}║  ❌ ACCESO DENEGADO                     ${R}║${N}"
  echo -e "${R}║  Key inválida                           ${R}║${N}"
  echo -e "${R}╚══════════════════════════════════════════╝${N}"
  exit 1
fi

DEVICE=$(settings get secure android_id)
echo -e "${Y}📱 Verificando identidad...${N}"

RESP=$(curl -s "$CHECK?key=$KEY&device=$DEVICE")
VALID=$(echo "$RESP" | python3 -c "import sys,json;print(json.load(sys.stdin).get('valid'))" 2>/dev/null)
ERROR=$(echo "$RESP" | python3 -c "import sys,json;print(json.load(sys.stdin).get('error',''))" 2>/dev/null)

if [ "$VALID" != "True" ]; then
  echo -e "${R}╔══════════════════════════════════════════╗${N}"
  echo -e "${R}║  ❌ ACCESO DENEGADO                     ${R}║${N}"
  echo -e "${R}║  ${W}$ERROR${R}${N}"
  echo -e "${R}╚══════════════════════════════════════════╝${N}"
  exit 1
fi

echo -e "${G}✅ Acceso concedido - Bienvenido${N}"
sleep 1
clear

# === BANNER LOGIN ===
echo -e "${R}╔══════════════════════════════════════════╗${N}"
echo -e "${R}║${Y}         INICIAR SESIÓN                  ${R}║${N}"
echo -e "${R}╚══════════════════════════════════════════╝${N}"
echo ""

# === SELECCIONAR JUEGO ===
echo -e "${C}🎮 Selecciona el juego:${N}"
echo -e "  ${Y}[1]${W} 🚗 CPM1 - Car Parking Multiplayer${N}"
echo -e "  ${Y}[2]${W} 🚗 CPM2 - Car Parking Multiplayer 2${N}"
read -p "Opción: " GAME

case $GAME in
  1) GNAME="CPM1" ;;
  2) GNAME="CPM2" ;;
  *) echo -e "${R}❌ Inválido${N}"; exit 1 ;;
esac

echo ""
read -p "📧 Email: " EMAIL
read -sp "🔒 Password: " PASSWORD
echo ""

loading

# === LOGIN ===
LOGIN=$(curl -s -X POST "$API" -H "Content-Type: application/json" \
  -d "{\"action\":\"login\",\"game\":\"$GAME\",\"email\":\"$EMAIL\",\"password\":\"$PASSWORD\"}")

TOKEN=$(echo "$LOGIN" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))" 2>/dev/null)
ERROR=$(echo "$LOGIN" | python3 -c "import sys,json;print(json.load(sys.stdin).get('error',{}).get('message',''))" 2>/dev/null)

if [ -z "$TOKEN" ]; then
  echo -e "${R}❌ Error: Credenciales incorrectas${N}"
  exit 1
fi

echo -e "${G}✅ Sesión iniciada correctamente${N}"
sleep 1

# === MENÚ PRINCIPAL ===
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
  echo ""
  read -p "Selecciona: " OPT

  case $OPT in
    1)
      if [ "$GAME" = "1" ]; then
        clear
        echo -e "${Y}╔══════════════════════════════════════════╗${N}"
        echo -e "${Y}║         👑 ACTIVAR RANGO KING            ║${N}"
        echo -e "${Y}╚══════════════════════════════════════════╝${N}"
        loading
        curl -s -X POST "$API" -H "Content-Type: application/json" \
          -d "{\"action\":\"king\",\"token\":\"$TOKEN\"}" > /dev/null
        echo -e "${G}✅ Rango King Activado Correctamente${N}"
        echo -e "${W}📲 Entra al juego para ver los cambios.${N}"
        echo ""
        read -p "Presiona Enter para continuar..."
      fi
      ;;
    2)
      if [ "$GAME" = "1" ]; then
        clear
        echo -e "${B}╔══════════════════════════════════════════╗${N}"
        echo -e "${B}║         📊 ESTADÍSTICAS                  ║${N}"
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
        echo ""
        read -p "Presiona Enter para continuar..."
      fi
      ;;
    3)
      if [ "$GAME" = "1" ]; then
        clear
        echo -e "${C}╔══════════════════════════════════════════╗${N}"
        echo -e "${C}║         🎁 RECOMPENSAS DIARIAS           ║${N}"
        echo -e "${C}╚══════════════════════════════════════════╝${N}"
        loading
        curl -s -X POST "$API" -H "Content-Type: application/json" \
          -d "{\"action\":\"rewards\",\"token\":\"$TOKEN\"}" | python3 -c "
import sys,json
d=json.load(sys.stdin)
r=json.loads(d.get('result','[]'))
tc=0;tm=0
for i,x in enumerate(r):
    s='✅ RECLAMADO' if x.get('status')==1 else '⬜ PENDIENTE'
    c=x.get('cash',0); m=x.get('coin',0); ca=x.get('car',0)
    extra=f' | 🚗 Auto:{ca}' if ca>0 else ''
    print(f'  Día {i+1}: {s} | 💵{c} | 🪙{m}{extra}')
    tc+=c; tm+=m
print(f'  ────────────────────────')
print(f'  💰 TOTAL PENDIENTE: {tc} Cash | 🪙 {tm} Coins')
"
        echo ""
        read -p "Presiona Enter para continuar..."
      fi
      ;;
    4)
      if [ "$GAME" = "1" ]; then
        clear
        echo -e "${M}╔══════════════════════════════════════════╗${N}"
        echo -e "${M}║         📋 TAREAS DIARIAS                ║${N}"
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
    print(f'     💰 Premio: {p.get(\"cash\",0)} Cash | 🪙 {p.get(\"coin\",0)} Coins')
"
        echo ""
        read -p "Presiona Enter para continuar..."
      fi
      ;;
    5)
      clear
      echo -e "${W}╔══════════════════════════════════════════╗${N}"
      echo -e "${W}║         📧 CAMBIAR EMAIL                 ║${N}"
      echo -e "${W}╚══════════════════════════════════════════╝${N}"
      read -p "📧 Nuevo Email: " NEWEMAIL
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
      read -p "Presiona Enter para continuar..."
      ;;
    6)
      clear
      echo -e "${W}╔══════════════════════════════════════════╗${N}"
      echo -e "${W}║         🔒 CAMBIAR CONTRASEÑA            ║${N}"
      echo -e "${W}╚══════════════════════════════════════════╝${N}"
      read -sp "🔒 Nueva Contraseña: " NEWPASS
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
      read -p "Presiona Enter para continuar..."
      ;;
    7)
      exec bash "$0"
      ;;
    0)
      clear
      echo -e "${R}╔══════════════════════════════════════════╗${N}"
      echo -e "${R}║     👋 ¡HASTA LUEGO!                    ║${N}"
      echo -e "${R}║  JOZETH TOOLS CPM - By @Asmodeo        ║${N}"
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

chmod +x /sdcard/cpm.sh
