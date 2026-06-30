cat > $PREFIX/bin/cpm << 'SCRIPT'
#!/bin/bash
# =============================================
# JOZETH TOOLS v5.0 - NEON EDITION
# CPM1 | CPM2 | TRAFFIC RACER | NEXTGEN TRUCK
# =============================================
R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;33m'; B='\033[1;34m'
M='\033[1;35m'; C='\033[1;36m'; W='\033[1;37m'; N='\033[0m'

API="https://bot-api.devwebasmodeo.workers.dev/api"
CHECK="https://bot-api.devwebasmodeo.workers.dev/validate"

sep() { echo -e "\033[38;5;17m━━\033[38;5;19m━━\033[38;5;27m━━\033[38;5;39m━━\033[38;5;160m━━\033[38;5;196m━━\033[38;5;160m━━\033[38;5;39m━━\033[38;5;27m━━\033[38;5;19m━━\033[38;5;17m━━${N}"; }
spin() { local s=('◐' '◓' '◑' '◒'); for i in {1..12}; do echo -ne "\r  ${R}${s[$((i%4))]}${N} ${W}Procesando...${N}"; sleep 0.1; done; echo -e "\r  ${G}✔${N} ${W}Completado${N}    "; }
read_i() { echo -ne "  ${R}▸${N} ${W}${1}${N} "; [ "$3" = "s" ] && read -s $2 || read $2; echo -ne "$N"; [ "$3" = "s" ] && echo ""; }

clear
echo -e "${R}╔══════════════════════════════════════════╗"
echo -e "${R}║${W}  JOZETH TOOLS v5.0 - NEON EDITION      ${R}║"
echo -e "${R}║${G}  CPM1 | CPM2 | Traffic | Truck         ${R}║"
echo -e "${R}╚══════════════════════════════════════════╝${N}"
sep; echo ""; read_i "🔑 Key:" KEY; echo ""; spin
RESP=$(curl -s "$CHECK?key=$KEY"); VALID=$(echo "$RESP" | python3 -c "import sys,json;print(json.load(sys.stdin).get('valid'))" 2>/dev/null)
[ "$VALID" != "True" ] && { echo -e "  ${R}✘ ACCESO DENEGADO${N}"; exit 1; }
echo -e "  ${G}✔ Acceso Concedido${N}"; sleep 1; clear

echo -e "${R}╔══════════════════════════════════════════╗"
echo -e "${R}║${W}  🔐 INICIAR SESIÓN                     ${R}║"
echo -e "${R}╚══════════════════════════════════════════╝${N}"
echo -e "  ${B}[1]${W} 🚗 CPM1  ${B}[2]${W} 🚗 CPM2  ${B}[3]${W} 🏎️ Traffic  ${B}[4]${W} 🚛 Truck${N}"
read_i "▶ Juego:" GAME
case $GAME in 
  1) GNAME="CPM1";;
  2) GNAME="CPM2";;
  3) GNAME="TRAFFIC RACER";;
  4) GNAME="NEXTGEN TRUCK";;
  *) exit 1;;
esac
read_i "📧 Email:" EMAIL; read_i "🔒 Pass:" PASSWORD s; spin
LOGIN=$(curl -s -X POST "$API" -H "Content-Type: application/json" -d "{\"action\":\"login\",\"game\":\"$GAME\",\"email\":\"$EMAIL\",\"password\":\"$PASSWORD\"}")
TOKEN=$(echo "$LOGIN" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))" 2>/dev/null)
[ -z "$TOKEN" ] && { echo -e "  ${R}✘ Error${N}"; exit 1; }
echo -e "  ${G}✔ OK${N}"; sleep 1

while true; do
  clear
  echo -e "${R}╔══════════════════════════════════════════╗"
  echo -e "${R}║${W}  ${GNAME} - ${EMAIL}${N}"
  echo -e "${R}╠══════════════════════════════════════════╣"
  
  case $GAME in
    1) # CPM1
      echo -e "${R}║${N} ${B}[1]${W} 👑 King  ${B}[2]${W} 📊 Stats  ${B}[3]${W} 🎁 Rew  ${B}[4]${W} 📋 Task${R}║${N}"
      ;;
    2) # CPM2
      echo -e "${R}║${N} ${B}[1]${W} 📧 Email  ${B}[2]${W} 🔒 Pass  ${B}[3]${W} 🆕 New${R}║${N}"
      ;;
    3) # Traffic Racer
      echo -e "${R}║${N} ${B}[1]${W} 💰 \$${N}  ${B}[2]${W} 🔥Boost${N}  ${B}[3]${W} 📊Lvl${N}  ${B}[4]${W} 🔧Tune${R}║${N}"
      echo -e "${R}║${N} ${B}[5]${W} 🚀FULL${N}  ${B}[6]${W} 📖Ver${R}║${N}"
      ;;
    4) # Nextgen Truck
      echo -e "${R}║${N} ${B}[1]${W} 💰 Gold+Coins  ${B}[2]${W} 📊 Nivel 100${R}║${N}"
      echo -e "${R}║${N} ${B}[3]${W} 🚛 Todos Autos  ${B}[4]${W} 🚀 FULL${R}║${N}"
      ;;
  esac
  
  echo -e "${R}║${N} ${B}[7]${W} 📧 Email  ${B}[8]${W} 🔒 Pass  ${B}[9]${W} 🆕 New  ${B}[0]${W} 🚪 Exit${R}║${N}"
  echo -e "${R}╚══════════════════════════════════════════╝${N}"
  read_i "▶ Opción:" OPT

  case $OPT in
    # ============ CPM1 ============
    1) [ "$GAME" = "1" ] && { spin; curl -s -X POST "$API" -d "{\"action\":\"king\",\"token\":\"$TOKEN\"}" > /dev/null; echo -e "${G}✔ King${N}"; read -p "Enter..."; }
       [ "$GAME" = "3" ] && { read_i "💰 Dollars:" D; read_i "🪙 Gold:" G; spin; curl -s -X POST "$API" -d "{\"action\":\"traffic_main\",\"token\":\"$TOKEN\",\"dollars\":$D,\"gold\":$G}" > /dev/null; echo -e "${G}✔ \$${D}+${G}G${N}"; read -p "Enter..."; }
       [ "$GAME" = "4" ] && { spin; curl -s -X POST "$API" -d "{\"action\":\"truck_money\",\"token\":\"$TOKEN\"}" > /dev/null; echo -e "${G}✔ Gold:999K Coins:999M${N}"; read -p "Enter..."; }
       ;;
    2) [ "$GAME" = "1" ] && { spin; curl -s -X POST "$API" -d "{\"action\":\"status\",\"token\":\"$TOKEN\"}" | python3 -c "import sys,json;d=json.load(sys.stdin);r=json.loads(d.get('result','{}'));l=r.get('level',0);print(f'🏆 Nivel:{l} | 👑 King:{\"SI\" if l>=6 else \"NO\"}')"; read -p "Enter..."; }
       [ "$GAME" = "3" ] && { read_i "🔥 Boosters:" B; spin; curl -s -X POST "$API" -d "{\"action\":\"traffic_boosters\",\"token\":\"$TOKEN\",\"boosters\":$B}" > /dev/null; echo -e "${G}✔ x${B}${N}"; read -p "Enter..."; }
       [ "$GAME" = "4" ] && { spin; curl -s -X POST "$API" -d "{\"action\":\"truck_level\",\"token\":\"$TOKEN\"}" > /dev/null; echo -e "${G}✔ Nivel 100 + Trabajos MAX${N}"; read -p "Enter..."; }
       ;;
    3) [ "$GAME" = "1" ] && { spin; curl -s -X POST "$API" -d "{\"action\":\"rewards\",\"token\":\"$TOKEN\"}" | python3 -c "import sys,json;d=json.load(sys.stdin);r=json.loads(d.get('result','[]'));[print(f'D{i+1}: {\"✅\" if x.get(\"status\")==1 else \"⬜\"} \${x.get(\"cash\",0)}') for i,x in enumerate(r)]"; read -p "Enter..."; }
       [ "$GAME" = "3" ] && { spin; curl -s -X POST "$API" -d "{\"action\":\"traffic_level\",\"token\":\"$TOKEN\"}" > /dev/null; echo -e "${G}✔ Nivel 50${N}"; read -p "Enter..."; }
       [ "$GAME" = "4" ] && { spin; curl -s -X POST "$API" -d "{\"action\":\"truck_vehicles\",\"token\":\"$TOKEN\"}" > /dev/null; echo -e "${G}✔ 85 vehículos${N}"; read -p "Enter..."; }
       ;;
    4) [ "$GAME" = "1" ] && { spin; curl -s -X POST "$API" -d "{\"action\":\"tasks\",\"token\":\"$TOKEN\"}" | python3 -c "import sys,json;d=json.load(sys.stdin);r=json.loads(d.get('result','{}'));[print(f'{t.get(\"name\")}: {t.get(\"current\")}/{t.get(\"goal\")}') for t in r.get('tasks',[])]"; read -p "Enter..."; }
       [ "$GAME" = "3" ] && { spin; curl -s -X POST "$API" -d "{\"action\":\"traffic_tuning\",\"token\":\"$TOKEN\"}" > /dev/null; echo -e "${G}✔ Tuning 10${N}"; read -p "Enter..."; }
       [ "$GAME" = "4" ] && { spin; curl -s -X POST "$API" -d "{\"action\":\"truck_full\",\"token\":\"$TOKEN\"}" > /dev/null; echo -e "${G}✔ FULL COMPLETO${N}"; read -p "Enter..."; }
       ;;
    5) [ "$GAME" = "3" ] && { read_i "💰 Dollars:" D; read_i "🪙 Gold:" G; read_i "🔥 Boosters:" B; spin; curl -s -X POST "$API" -d "{\"action\":\"traffic_full\",\"token\":\"$TOKEN\",\"dollars\":$D,\"gold\":$G,\"boosters\":$B}" > /dev/null; echo -e "${G}✔ FULL${N}"; read -p "Enter..."; } ;;
    6) [ "$GAME" = "3" ] && { spin; curl -s -X POST "$API" -d "{\"action\":\"traffic_status\",\"token\":\"$TOKEN\"}" | python3 -c "import sys,json;d=json.load(sys.stdin);print(d.get('message','OK'))"; read -p "Enter..."; } ;;
    7) { read_i "📧 Nuevo Email:" NE; spin; R=$(curl -s -X POST "$API" -d "{\"action\":\"change_email\",\"token\":\"$TOKEN\",\"newEmail\":\"$NE\",\"password\":\"$PASSWORD\",\"game\":\"$GAME\"}"); NT=$(echo "$R" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))"); [ -n "$NT" ] && { TOKEN="$NT"; EMAIL="$NE"; echo -e "${G}✔${N}"; } || echo -e "${R}✘${N}"; read -p "Enter..."; } ;;
    8) { read_i "🔒 Nueva Pass:" NP s; spin; R=$(curl -s -X POST "$API" -d "{\"action\":\"change_password\",\"token\":\"$TOKEN\",\"newPass\":\"$NP\",\"email\":\"$EMAIL\",\"game\":\"$GAME\"}"); NT=$(echo "$R" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))"); [ -n "$NT" ] && { TOKEN="$NT"; PASSWORD="$NP"; echo -e "${G}✔${N}"; } || echo -e "${R}✘${N}"; read -p "Enter..."; } ;;
    9) { read_i "📧 Email:" NE; read_i "🔒 Pass:" NP s; spin; R=$(curl -s -X POST "$API" -d "{\"action\":\"signup\",\"game\":\"$GAME\",\"email\":\"$NE\",\"password\":\"$NP\"}"); NT=$(echo "$R" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))"); [ -n "$NT" ] && { TOKEN="$NT"; EMAIL="$NE"; PASSWORD="$NP"; echo -e "${G}✔ Creada${N}"; } || echo -e "${R}✘${N}"; read -p "Enter..."; } ;;
    0) echo -e "${R}👋${N}"; exit 0 ;;
  esac
done
SCRIPT

chmod +x $PREFIX/bin/cpmsep() {
  echo -e "  \033[38;5;17m━━\033[38;5;18m━━\033[38;5;19m━━\033[38;5;20m━━\033[38;5;27m━━\033[38;5;33m━━\033[38;5;39m━━\033[38;5;160m━━\033[38;5;196m━━\033[38;5;197m━━\033[38;5;203m━━\033[38;5;196m━━\033[38;5;39m━━\033[38;5;33m━━\033[38;5;27m━━\033[38;5;20m━━\033[38;5;19m━━\033[38;5;18m━━\033[38;5;17m━━${N}"
}

# === SPINNER NEÓN ===
spin_loading() {
  local msg="${1:-Procesando}"
  local sp=('◐' '◓' '◑' '◒')
  for i in {1..20}; do
    local s="${sp[$((i % 4))]}"
    echo -ne "\r  ${BRED}${s}${N} ${WHT}${msg}...${N}"
    sleep 0.08
  done
  echo -e "\r  ${GRN}✔${N} ${WHT}${msg}${N}    "
}

# === LEER INPUT (texto de escritura en rojo neón) ===
read_input() {
  local prompt="$1"
  local var="$2"
  local secret="${3:-no}"
  echo -ne "  ${BRED}▸${N} ${WHT}${prompt}${N} "
  echo -ne "\033[38;5;196m"
  if [ "$secret" = "yes" ]; then
    read -s "$var"
    echo -ne "$N"
    echo ""
  else
    read "$var"
    echo -ne "$N"
  fi
}

# === BANNER NEÓN ===
show_banner() {
  clear
  echo ""
  sep
  echo ""
  echo -e "\033[38;5;196m   ▄▀▀ █▀█ █▄█   \033[38;5;27m▀█▀ █▀█ █▀█ █   █▀▀${N}"
  echo -e "\033[38;5;197m   ▀▄▄ █▀▀ █ █    \033[38;5;33m █  █ █ █ █ █   ▀▀█${N}"
  echo -e "\033[38;5;203m        ▀  ▀ ▀    \033[38;5;39m ▀  ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀${N}"
  echo ""
  echo -e "\033[38;5;17m  ██\033[38;5;18m██\033[38;5;19m██\033[38;5;20m█ \033[38;5;196m█▀▀ █▀█ █▀█\033[38;5;20m █\033[38;5;19m██\033[38;5;18m██\033[38;5;17m██${N}"
  echo -e "\033[38;5;17m  ██\033[38;5;18m██\033[38;5;19m██\033[38;5;20m█ \033[38;5;196m█   █▀▀ █ █\033[38;5;20m █\033[38;5;19m██\033[38;5;18m██\033[38;5;17m██${N}"
  echo -e "\033[38;5;17m  ██\033[38;5;18m██\033[38;5;19m██\033[38;5;20m█ \033[38;5;196m▀▀▀ ▀   ▀▀▀\033[38;5;20m █\033[38;5;19m██\033[38;5;18m██\033[38;5;17m██${N}"
  echo ""
  echo -e "  \033[38;5;196m◈\033[38;5;197m◈\033[38;5;203m◈\033[38;5;196m  \033[1;37mNEON RED EDITION  v4.0\033[0m  \033[38;5;203m◈\033[38;5;197m◈\033[38;5;196m◈${N}"
  echo -e "  ${GRY}github.com/JOZETH-DEV/jozeth-dev-tools${N}"
  echo ""
  sep
  echo ""
}

# === CABECERA DE SECCIÓN ===
section() {
  local title="$1"
  echo ""
  sep
  echo -e "  \033[38;5;196m◈\033[38;5;197m◈\033[38;5;203m◈${N} ${WHT}${title}${N} \033[38;5;203m◈\033[38;5;197m◈\033[38;5;196m◈${N}"
  sep
  echo ""
}

# ==========================================
# VALIDAR KEY
# ==========================================
show_banner

echo -e "  ${BRED}◉${N} ${WHT}Sistema de Acceso Protegido${N}"
echo -e "  ${GRY}◎ Obtén tu Key: ${LBLUE}@cpm1_tools_jozeth_bot${GRY} en Telegram${N}"
echo ""
sep
echo ""

read_input "🔑 Ingresa tu Key:" KEY

[ -z "$KEY" ] && { echo -e "\n  ${RED}✘ Error: Key requerida${N}\n"; exit 1; }

echo ""
spin_loading "Verificando Key"

RESP=$(curl -s "$CHECK?key=$KEY")
VALID=$(echo "$RESP" | python3 -c "import sys,json;print(json.load(sys.stdin).get('valid'))" 2>/dev/null)
ERROR=$(echo "$RESP" | python3 -c "import sys,json;print(json.load(sys.stdin).get('error',''))" 2>/dev/null)

if [ "$VALID" != "True" ]; then
  echo ""
  sep
  echo -e "  ${BRED}✘  ACCESO DENEGADO${N}"
  echo -e "  ${WHT}${ERROR}${N}"
  sep
  echo ""
  exit 1
fi

echo -e "  ${GRN}✔  Acceso Concedido${N}"
sleep 1

# ==========================================
# LOGIN
# ==========================================
show_banner
section "🔐 INICIAR SESIÓN"

echo -e "  ${LBLUE}◈${N} ${WHT}Selecciona tu juego:${N}"
echo ""
echo -e "  \033[38;5;196m[1]${N} ${WHT}🚗 CPM1${N}"
echo -e "  \033[38;5;197m[2]${N} ${WHT}🚗 CPM2${N}"
echo ""
read_input "▶ Opción:" GAME

case $GAME in
  1) GNAME="CPM1";;
  2) GNAME="CPM2";;
  *) echo -e "\n  ${RED}✘ Opción inválida${N}\n"; exit 1;;
esac

echo ""
read_input "📧 Email:" EMAIL
read_input "🔒 Password:" PASSWORD yes

echo ""
spin_loading "Iniciando sesión"

LOGIN=$(curl -s -X POST "$API" -H "Content-Type: application/json" \
  -d "{\"action\":\"login\",\"game\":\"$GAME\",\"email\":\"$EMAIL\",\"password\":\"$PASSWORD\"}")
TOKEN=$(echo "$LOGIN" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))" 2>/dev/null)

[ -z "$TOKEN" ] && { echo -e "\n  ${RED}✘ Credenciales incorrectas${N}\n"; exit 1; }
echo -e "  ${GRN}✔  Sesión iniciada${N}"
sleep 1

# ==========================================
# MENÚ PRINCIPAL
# ==========================================
while true; do
  show_banner

  echo -ne "  \033[38;5;196m◈${N} ${WHT}${GNAME}${N}  ${GRY}${EMAIL}${N}"
  echo ""
  echo ""
  sep
  echo ""

  if [ "$GAME" = "1" ]; then
    echo -e "  \033[38;5;196m[1]${N} ${WHT}👑 Activar Rango King${N}"
    echo -e "  \033[38;5;197m[2]${N} ${WHT}📊 Ver Estadísticas${N}"
    echo -e "  \033[38;5;203m[3]${N} ${WHT}🎁 Ver Recompensas${N}"
    echo -e "  \033[38;5;160m[4]${N} ${WHT}📋 Tareas Diarias${N}"
  fi
  echo -e "  \033[38;5;39m[5]${N}  ${WHT}📧 Cambiar Email${N}"
  echo -e "  \033[38;5;33m[6]${N}  ${WHT}🔒 Cambiar Contraseña${N}"
  echo -e "  \033[38;5;27m[7]${N}  ${WHT}🆕 Crear Cuenta Nueva${N}"
  echo -e "  \033[38;5;20m[8]${N}  ${WHT}🔄 Cerrar Sesión${N}"
  echo -e "  \033[38;5;196m[0]${N}  ${WHT}🚪 Salir${N}"
  echo ""
  sep
  echo ""
  read_input "▶ Opción:" OPT

  case $OPT in
    1) [ "$GAME" = "1" ] && {
      show_banner
      section "👑 ACTIVAR RANGO KING"
      spin_loading "Activando King"
      curl -s -X POST "$API" -d "{\"action\":\"king\",\"token\":\"$TOKEN\"}" > /dev/null
      echo -e "  ${GRN}✔  Rango King Activado${N}"
      echo ""
      read -p "  Presiona Enter para continuar..."
    };;

    2) [ "$GAME" = "1" ] && {
      show_banner
      section "📊 ESTADÍSTICAS"
      spin_loading "Cargando estadísticas"
      curl -s -X POST "$API" -d "{\"action\":\"status\",\"token\":\"$TOKEN\"}" | python3 -c "
import sys, json

RED     = '\033[38;5;196m'
LBLUE   = '\033[38;5;39m'
WHT     = '\033[1;37m'
GRY     = '\033[38;5;245m'
GRN     = '\033[1;32m'
YEL     = '\033[1;33m'
N       = '\033[0m'

RANKS = {1:'BEGINNER', 2:'DRIVER', 3:'RACER', 4:'PRO', 5:'EXPERT', 6:'KING'}

d = json.load(sys.stdin)
r = json.loads(d.get('result','{}'))
lvl = r.get('level', 0)
rank = RANKS.get(lvl, 'SIN RANGO')
reports = r.get('reports','?')

# Color del rango
if lvl == 6:
    rc = '\033[1;33m'   # dorado para KING
elif lvl >= 4:
    rc = '\033[38;5;196m'  # rojo para PRO/EXPERT
elif lvl >= 2:
    rc = '\033[38;5;39m'   # azul para DRIVER/RACER
else:
    rc = '\033[38;5;245m'  # gris para BEGINNER

print(f'  {LBLUE}┌──────────────────────────{N}')
print(f'  {LBLUE}│{N}  {GRY}Nivel    {N}  {WHT}{lvl}{N}')
print(f'  {LBLUE}│{N}  {GRY}Rango    {N}  {rc}{rank}{N}')
print(f'  {LBLUE}│{N}  {GRY}Reportes {N}  {YEL}{reports}{N}')
print(f'  {LBLUE}└──────────────────────────{N}')
"
      echo ""
      read -p "  Presiona Enter para continuar..."
    };;

    3) [ "$GAME" = "1" ] && {
      show_banner
      section "🎁 RECOMPENSAS"
      spin_loading "Cargando recompensas"
      curl -s -X POST "$API" -d "{\"action\":\"rewards\",\"token\":\"$TOKEN\"}" | python3 -c "
import sys, json

RED   = '\033[38;5;196m'
BLUE  = '\033[38;5;39m'
WHT   = '\033[1;37m'
GRY   = '\033[38;5;245m'
GRN   = '\033[1;32m'
YEL   = '\033[1;33m'
N     = '\033[0m'

d = json.load(sys.stdin)
r = json.loads(d.get('result','[]'))
for i, x in enumerate(r):
    status = '✔' if x.get('status') == 1 else '○'
    color  = GRN if x.get('status') == 1 else GRY
    print(f'  {BLUE}Día {i+1:2d}{N}  {color}{status}{N}  {YEL}\${x.get(\"cash\",0)}{N}  {WHT}🪙{x.get(\"coin\",0)}{N}')
"
      echo ""
      read -p "  Presiona Enter para continuar..."
    };;

    4) [ "$GAME" = "1" ] && {
      show_banner
      section "📋 TAREAS DIARIAS"
      spin_loading "Cargando tareas"
      curl -s -X POST "$API" -d "{\"action\":\"tasks\",\"token\":\"$TOKEN\"}" | python3 -c "
import sys, json

RED   = '\033[38;5;196m'
BLUE  = '\033[38;5;39m'
WHT   = '\033[1;37m'
GRY   = '\033[38;5;245m'
GRN   = '\033[1;32m'
N     = '\033[0m'

d = json.load(sys.stdin)
r = json.loads(d.get('result','{}'))
for t in r.get('tasks', []):
    cur  = t.get('current', 0)
    goal = t.get('goal', 1)
    pct  = int((cur / goal) * 12) if goal > 0 else 0
    bar  = f'{GRN}' + '█' * pct + f'{GRY}' + '░' * (12 - pct) + f'{N}'
    print(f'  {RED}◈{N} {WHT}{t.get(\"name\")}{N}')
    print(f'    {GRY}{cur}/{goal}{N}  {bar}')
    print()
"
      echo ""
      read -p "  Presiona Enter para continuar..."
    };;

    5) {
      show_banner
      section "📧 CAMBIAR EMAIL"
      read_input "📧 Nuevo Email:" NEWEMAIL
      echo ""
      spin_loading "Actualizando email"
      RES=$(curl -s -X POST "$API" -d "{\"action\":\"change_email\",\"token\":\"$TOKEN\",\"newEmail\":\"$NEWEMAIL\",\"password\":\"$PASSWORD\",\"game\":\"$GAME\"}")
      NEWTOKEN=$(echo "$RES" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))" 2>/dev/null)
      [ -n "$NEWTOKEN" ] && { TOKEN="$NEWTOKEN"; EMAIL="$NEWEMAIL"; echo -e "  ${GRN}✔  Email actualizado${N}"; } || echo -e "  ${RED}✘  Error al cambiar email${N}"
      echo ""
      read -p "  Presiona Enter para continuar..."
    };;

    6) {
      show_banner
      section "🔒 CAMBIAR CONTRASEÑA"
      read_input "🔒 Nueva Contraseña:" NEWPASS yes
      echo ""
      spin_loading "Actualizando contraseña"
      RES=$(curl -s -X POST "$API" -d "{\"action\":\"change_password\",\"token\":\"$TOKEN\",\"newPass\":\"$NEWPASS\",\"email\":\"$EMAIL\",\"game\":\"$GAME\"}")
      NEWTOKEN=$(echo "$RES" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))" 2>/dev/null)
      [ -n "$NEWTOKEN" ] && { TOKEN="$NEWTOKEN"; PASSWORD="$NEWPASS"; echo -e "  ${GRN}✔  Contraseña actualizada${N}"; } || echo -e "  ${RED}✘  Error al cambiar contraseña${N}"
      echo ""
      read -p "  Presiona Enter para continuar..."
    };;

    7) {
      show_banner
      section "🆕 CREAR CUENTA NUEVA"
      read_input "📧 Email:" NEWEMAIL
      read_input "🔒 Password:" NEWPASS yes
      echo ""
      read_input "🔒 Confirmar Pass:" NEWPASS2 yes
      echo ""
      [ "$NEWPASS" != "$NEWPASS2" ] && { echo -e "  ${RED}✘  Las contraseñas no coinciden${N}"; echo ""; read -p "  Presiona Enter..."; continue; }
      spin_loading "Creando cuenta"
      RES=$(curl -s -X POST "$API" -d "{\"action\":\"signup\",\"game\":\"$GAME\",\"email\":\"$NEWEMAIL\",\"password\":\"$NEWPASS\"}")
      NEWTOKEN=$(echo "$RES" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))" 2>/dev/null)
      if [ -n "$NEWTOKEN" ]; then
        TOKEN="$NEWTOKEN"; EMAIL="$NEWEMAIL"; PASSWORD="$NEWPASS"
        spin_loading "Inicializando cuenta"
        curl -s -X POST "$API" -d "{\"action\":\"init_account\",\"token\":\"$TOKEN\"}" > /dev/null
        echo -e "  ${GRN}✔  Cuenta creada e inicializada${N}"
      else
        echo -e "  ${RED}✘  Error al crear la cuenta${N}"
      fi
      echo ""
      read -p "  Presiona Enter para continuar..."
    };;

    8) exec bash "$0" ;;

    0)
      echo ""
      echo -e "  \033[38;5;196m◈\033[38;5;197m◈\033[38;5;203m◈${N} ${WHT}¡Hasta luego!${N} \033[38;5;203m◈\033[38;5;197m◈\033[38;5;196m◈${N}"
      echo ""
      exit 0 ;;

    *) echo -e "\n  ${RED}✘ Opción inválida${N}"; sleep 1 ;;
  esac
done
SCRIPT

chmod +x $PREFIX/bin/cpm
