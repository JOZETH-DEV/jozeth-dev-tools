cat > $PREFIX/bin/cpm << 'SCRIPT'
#!/bin/bash
# =============================================
# JOZETH TOOLS CPM v4.0 - RAINBOW EDITION
# github.com/JOZETH-DEV/jozeth-dev-tools
# =============================================

# === COLORES ===
R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;33m'; B='\033[1;34m'
M='\033[1;35m'; C='\033[1;36m'; W='\033[1;37m'; N='\033[0m'

# Colores adicionales para rainbow más rico
ORANGE='\033[38;5;208m'
PINK='\033[38;5;213m'
LIME='\033[38;5;154m'
SKY='\033[38;5;39m'
GOLD='\033[38;5;220m'

API="https://bot-api.devwebasmodeo.workers.dev/api"
CHECK="https://bot-api.devwebasmodeo.workers.dev/validate"

# === FUNCIÓN RAINBOW TEXTO ===
rainbow_text() {
  local text="$1"
  local colors=("$R" "$ORANGE" "$Y" "$G" "$C" "$B" "$M" "$PINK")
  local len=${#colors[@]}
  local i=0
  for (( c=0; c<${#text}; c++ )); do
    echo -ne "${colors[$((i % len))]}${text:$c:1}"
    ((i++))
  done
  echo -ne "$N"
}

# === FUNCIÓN RAINBOW LÍNEA COMPLETA ===
rainbow_line() {
  local text="$1"
  local colors=("$R" "$Y" "$G" "$C" "$B" "$M")
  local idx=$(( RANDOM % ${#colors[@]} ))
  echo -e "${colors[$idx]}${text}${N}"
}

# === BARRA DE PROGRESO RAINBOW ===
loading() {
  local colors=("$R" "$ORANGE" "$Y" "$G" "$C" "$B" "$M" "$PINK")
  echo -ne "  "
  for i in {1..20}; do
    local color="${colors[$((i % ${#colors[@]}))]}"
    echo -ne "${color}█"
    sleep 0.05
  done
  echo -e " ${G}✓${N}"
}

# === SPINNER RAINBOW ===
spin_loading() {
  local msg="${1:-Procesando}"
  local spinners=('⣾' '⣽' '⣻' '⢿' '⡿' '⣟' '⣯' '⣷')
  local colors=("$R" "$Y" "$G" "$C" "$B" "$M")
  for i in {1..16}; do
    local s="${spinners[$((i % ${#spinners[@]}))]}"
    local col="${colors[$((i % ${#colors[@]}))]}"
    echo -ne "\r  ${col}${s}${N} ${W}${msg}...${N}"
    sleep 0.1
  done
  echo -e "\r  ${G}✓${N} ${W}${msg}${N}    "
}

# === LEER CON PROMPT RAINBOW ===
read_rainbow() {
  local prompt_text="$1"
  local varname="$2"
  local secret="${3:-no}"
  
  # Prompt rainbow
  echo -ne "  "
  rainbow_text "${prompt_text}"
  echo -ne " "
  
  if [ "$secret" = "yes" ]; then
    read -s "$varname"
    echo ""
  else
    # Activar color de escritura (cyan brillante)
    echo -ne "\033[1;96m"
    read "$varname"
    echo -ne "$N"
  fi
}

# === SEPARADOR RAINBOW ===
separator() {
  local width=44
  local chars='━'
  local colors=("$R" "$ORANGE" "$Y" "$G" "$C" "$B" "$M" "$PINK")
  echo -ne "  "
  for i in $(seq 1 $width); do
    echo -ne "${colors[$((i % ${#colors[@]}))]}${chars}"
  done
  echo -e "$N"
}

# === BANNER ===
show_banner() {
  clear
  echo ""
  separator

  local lines=(
    "     ██╗ ██████╗ ███████╗███████╗████████╗██╗  ██╗     "
    "     ██║██╔═══██╗╚══███╔╝██╔════╝╚══██╔══╝██║  ██║     "
    "     ██║██║   ██║  ███╔╝ █████╗     ██║   ███████║     "
    "██   ██║██║   ██║ ███╔╝  ██╔══╝     ██║   ██╔══██║     "
    "╚█████╔╝╚██████╔╝███████╗███████╗   ██║   ██║  ██║     "
    " ╚════╝  ╚═════╝ ╚══════╝╚══════╝   ╚═╝   ╚═╝  ╚═╝     "
  )

  local colors=("$R" "$ORANGE" "$Y" "$G" "$C" "$B")
  for i in "${!lines[@]}"; do
    echo -e "  ${colors[$i]}${lines[$i]}${N}"
  done

  echo ""
  separator
  echo ""
  
  # Info centrada rainbow
  local title="  ★  CPM TOOLS v4.0 - RAINBOW EDITION  ★"
  rainbow_text "$title"
  echo ""
  echo -e "  ${W}github.com/JOZETH-DEV/jozeth-dev-tools${N}"
  echo ""
  separator
  echo ""
}

# === CAJA CON BORDE RAINBOW ===
box_header() {
  local title="$1"
  local color="$2"
  echo ""
  separator
  echo -e "  ${color}  ◈  ${W}${title}${color}  ◈${N}"
  separator
  echo ""
}

# === VALIDAR KEY ===
show_banner

echo -e "  ${C}◉${N} ${W}Sistema de Acceso Protegido${N}"
echo -e "  ${Y}◎${N} ${W}Obtén tu Key: ${C}@CPM_Tool_Bot${N} en Telegram"
echo ""
separator
echo ""

read_rainbow "🔑 Ingresa tu Key:" KEY

[ -z "$KEY" ] && { echo -e "\n  ${R}✗ Error: Key requerida${N}\n"; exit 1; }

echo ""
spin_loading "Verificando Key"

RESP=$(curl -s "$CHECK?key=$KEY")
VALID=$(echo "$RESP" | python3 -c "import sys,json;print(json.load(sys.stdin).get('valid'))" 2>/dev/null)
ERROR=$(echo "$RESP" | python3 -c "import sys,json;print(json.load(sys.stdin).get('error',''))" 2>/dev/null)

if [ "$VALID" != "True" ]; then
  echo ""
  separator
  echo -e "  ${R}✗  ACCESO DENEGADO${N}"
  echo -e "  ${W}${ERROR}${N}"
  separator
  echo ""
  exit 1
fi

echo -e "  ${G}✓  Acceso Concedido — Bienvenido${N}"
sleep 1

# === LOGIN ===
show_banner
box_header "🔐 INICIAR SESIÓN" "$Y"

echo -e "  ${C}◈${N} ${W}Selecciona tu juego:${N}"
echo ""
echo -e "  ${Y}[1]${N} ${W}🚗 CPM1${N}"
echo -e "  ${Y}[2]${N} ${W}🚗 CPM2${N}"
echo ""
read_rainbow "▶  Opción:" GAME

case $GAME in
  1) GNAME="CPM1";;
  2) GNAME="CPM2";;
  *) echo -e "\n  ${R}✗ Opción inválida${N}\n"; exit 1;;
esac

echo ""
read_rainbow "📧 Email:" EMAIL
read_rainbow "🔒 Password:" PASSWORD yes

echo ""
spin_loading "Iniciando sesión"

LOGIN=$(curl -s -X POST "$API" -H "Content-Type: application/json" \
  -d "{\"action\":\"login\",\"game\":\"$GAME\",\"email\":\"$EMAIL\",\"password\":\"$PASSWORD\"}")
TOKEN=$(echo "$LOGIN" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))" 2>/dev/null)

[ -z "$TOKEN" ] && { echo -e "\n  ${R}✗ Credenciales incorrectas${N}\n"; exit 1; }
echo -e "  ${G}✓  Sesión iniciada correctamente${N}"
sleep 1

# === MENÚ PRINCIPAL ===
while true; do
  show_banner

  # Info de cuenta
  echo -ne "  "
  rainbow_text "● $GNAME"
  echo -ne "  ${W}${EMAIL}${N}"
  echo ""
  echo ""
  separator
  echo ""

  if [ "$GAME" = "1" ]; then
    echo -e "  ${R}[1]${N} ${W}👑 Activar Rango King${N}"
    echo -e "  ${Y}[2]${N} ${W}📊 Ver Estadísticas${N}"
    echo -e "  ${G}[3]${N} ${W}🎁 Ver Recompensas${N}"
    echo -e "  ${C}[4]${N} ${W}📋 Tareas Diarias${N}"
  fi
  echo -e "  ${B}[5]${N} ${W}📧 Cambiar Email${N}"
  echo -e "  ${M}[6]${N} ${W}🔒 Cambiar Contraseña${N}"
  echo -e "  ${PINK}[7]${N} ${W}🆕 Crear Cuenta Nueva${N}"
  echo -e "  ${ORANGE}[8]${N} ${W}🔄 Cerrar Sesión${N}"
  echo -e "  ${R}[0]${N} ${W}🚪 Salir${N}"
  echo ""
  separator
  echo ""
  read_rainbow "▶  Opción:" OPT

  case $OPT in
    1) [ "$GAME" = "1" ] && {
      show_banner
      box_header "👑 ACTIVAR RANGO KING" "$Y"
      spin_loading "Activando King"
      curl -s -X POST "$API" -d "{\"action\":\"king\",\"token\":\"$TOKEN\"}" > /dev/null
      echo -e "  ${G}✓  Rango King Activado${N}"
      echo ""
      read -p "  Presiona Enter para continuar..."
    };;
    2) [ "$GAME" = "1" ] && {
      show_banner
      box_header "📊 ESTADÍSTICAS" "$B"
      spin_loading "Cargando stats"
      curl -s -X POST "$API" -d "{\"action\":\"status\",\"token\":\"$TOKEN\"}" | python3 -c "
import sys,json
d=json.load(sys.stdin)
r=json.loads(d.get('result','{}'))
l=r.get('level',0)
rank='KING ✅' if l>=6 else 'Normal ❌'
print(f'  \033[1;33m🏆 Nivel   :\033[0m \033[1;37m{l}\033[0m')
print(f'  \033[1;35m👑 Rango   :\033[0m \033[1;37m{rank}\033[0m')
print(f'  \033[1;31m⚠️  Reportes:\033[0m \033[1;37m{r.get(\"reports\",\"?\")}\033[0m')
"
      echo ""
      read -p "  Presiona Enter para continuar..."
    };;
    3) [ "$GAME" = "1" ] && {
      show_banner
      box_header "🎁 RECOMPENSAS" "$G"
      spin_loading "Cargando recompensas"
      curl -s -X POST "$API" -d "{\"action\":\"rewards\",\"token\":\"$TOKEN\"}" | python3 -c "
import sys,json
d=json.load(sys.stdin)
r=json.loads(d.get('result','[]'))
colors=['\033[1;31m','\033[1;33m','\033[1;32m','\033[1;36m','\033[1;34m','\033[1;35m']
for i,x in enumerate(r):
    s='✅' if x.get('status')==1 else '⬜'
    c=colors[i % len(colors)]
    print(f'  {c}Día {i+1:2d}:\033[0m {s}  💵\033[1;33m{x.get(\"cash\",0)}\033[0m  🪙\033[1;37m{x.get(\"coin\",0)}\033[0m')
"
      echo ""
      read -p "  Presiona Enter para continuar..."
    };;
    4) [ "$GAME" = "1" ] && {
      show_banner
      box_header "📋 TAREAS DIARIAS" "$M"
      spin_loading "Cargando tareas"
      curl -s -X POST "$API" -d "{\"action\":\"tasks\",\"token\":\"$TOKEN\"}" | python3 -c "
import sys,json
d=json.load(sys.stdin)
r=json.loads(d.get('result','{}'))
colors=['\033[1;31m','\033[38;5;208m','\033[1;33m','\033[1;32m','\033[1;36m','\033[1;34m','\033[1;35m']
for i,t in enumerate(r.get('tasks',[])):
    c=colors[i % len(colors)]
    cur=t.get('current',0)
    goal=t.get('goal',1)
    pct=int((cur/goal)*10) if goal>0 else 0
    bar='█'*pct + '░'*(10-pct)
    print(f'  {c}📌 {t.get(\"name\")}\033[0m')
    print(f'     \033[1;37m{cur}/{goal}\033[0m  \033[1;32m{bar}\033[0m')
    print()
"
      echo ""
      read -p "  Presiona Enter para continuar..."
    };;
    5) {
      show_banner
      box_header "📧 CAMBIAR EMAIL" "$W"
      read_rainbow "📧 Nuevo Email:" NEWEMAIL
      echo ""
      spin_loading "Actualizando email"
      RES=$(curl -s -X POST "$API" -d "{\"action\":\"change_email\",\"token\":\"$TOKEN\",\"newEmail\":\"$NEWEMAIL\",\"password\":\"$PASSWORD\",\"game\":\"$GAME\"}")
      NEWTOKEN=$(echo "$RES" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))" 2>/dev/null)
      [ -n "$NEWTOKEN" ] && { TOKEN="$NEWTOKEN"; EMAIL="$NEWEMAIL"; echo -e "  ${G}✓  Email actualizado correctamente${N}"; } || echo -e "  ${R}✗  Error al cambiar email${N}"
      echo ""
      read -p "  Presiona Enter para continuar..."
    };;
    6) {
      show_banner
      box_header "🔒 CAMBIAR CONTRASEÑA" "$W"
      read_rainbow "🔒 Nueva Contraseña:" NEWPASS yes
      echo ""
      spin_loading "Actualizando contraseña"
      RES=$(curl -s -X POST "$API" -d "{\"action\":\"change_password\",\"token\":\"$TOKEN\",\"newPass\":\"$NEWPASS\",\"email\":\"$EMAIL\",\"game\":\"$GAME\"}")
      NEWTOKEN=$(echo "$RES" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))" 2>/dev/null)
      [ -n "$NEWTOKEN" ] && { TOKEN="$NEWTOKEN"; PASSWORD="$NEWPASS"; echo -e "  ${G}✓  Contraseña actualizada${N}"; } || echo -e "  ${R}✗  Error al cambiar contraseña${N}"
      echo ""
      read -p "  Presiona Enter para continuar..."
    };;
    7) {
      show_banner
      box_header "🆕 CREAR CUENTA NUEVA" "$G"
      read_rainbow "📧 Email:" NEWEMAIL
      read_rainbow "🔒 Password:" NEWPASS yes
      echo ""
      read_rainbow "🔒 Confirmar Pass:" NEWPASS2 yes
      echo ""
      [ "$NEWPASS" != "$NEWPASS2" ] && { echo -e "  ${R}✗  Las contraseñas no coinciden${N}"; echo ""; read -p "  Presiona Enter..."; continue; }
      spin_loading "Creando cuenta"
      RES=$(curl -s -X POST "$API" -d "{\"action\":\"signup\",\"game\":\"$GAME\",\"email\":\"$NEWEMAIL\",\"password\":\"$NEWPASS\"}")
      NEWTOKEN=$(echo "$RES" | python3 -c "import sys,json;print(json.load(sys.stdin).get('idToken',''))" 2>/dev/null)
      if [ -n "$NEWTOKEN" ]; then
        TOKEN="$NEWTOKEN"; EMAIL="$NEWEMAIL"; PASSWORD="$NEWPASS"
        spin_loading "Inicializando cuenta"
        curl -s -X POST "$API" -d "{\"action\":\"init_account\",\"token\":\"$TOKEN\"}" > /dev/null
        echo -e "  ${G}✓  Cuenta creada e inicializada${N}"
      else
        echo -e "  ${R}✗  Error al crear la cuenta${N}"
      fi
      echo ""
      read -p "  Presiona Enter para continuar..."
    };;
    8) exec bash "$0" ;;
    0)
      echo ""
      echo -ne "  "
      rainbow_text "★ ¡Hasta luego! Vuelve pronto ★"
      echo -e "\n"
      exit 0 ;;
    *) echo -e "\n  ${R}✗ Opción inválida${N}"; sleep 1 ;;
  esac
done
SCRIPT

chmod +x $PREFIX/bin/cpm
