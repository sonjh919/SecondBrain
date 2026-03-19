---
cssclasses:
  - wide
---

```dataviewjs

// -- LIGHT MODE DETECTION & THEMING ----------
function detectIsDarkMode(){
    const body = document.body;
    const root = document.documentElement;

    if(body?.classList?.contains("theme-dark")) return true;
    if(body?.classList?.contains("theme-light")) return false;

    const dataTheme = root?.getAttribute?.("data-theme") || body?.getAttribute?.("data-theme") || "";
    if(dataTheme === "obsidian"){
        const resolvedTheme = document.body?.className || "";
        if(resolvedTheme.includes("theme-dark")) return true;
        if(resolvedTheme.includes("theme-light")) return false;
    }
    if(dataTheme.includes("dark")) return true;
    if(dataTheme.includes("light")) return false;

    const computedBg = window.getComputedStyle(root).backgroundColor || "";
    const channels = computedBg.match(/\d+(?:\.\d+)?/g);
    if(channels && channels.length >= 3){
        const [r, g, b] = channels.slice(0, 3).map(value => Number.parseFloat(value));
        const luminance = (r * 299 + g * 587 + b * 114) / 1000;
        return luminance < 128;
    }

    return true;
}

const isDarkMode = detectIsDarkMode();
const modalBg     = isDarkMode ? 'rgba(22,22,30,0.92)'   : 'rgba(255,255,255,0.82)';
const modalBorder = isDarkMode ? 'rgba(255,255,255,0.1)'  : 'rgba(0,0,0,0.07)';
const modalBlur   = 'backdrop-filter:blur(32px) saturate(200%);-webkit-backdrop-filter:blur(32px) saturate(200%);';
const modalText   = isDarkMode ? '#ffffff' : '#0f0f0f';
const modalShadow = isDarkMode ? '0 24px 64px rgba(0,0,0,0.7)' : '0 20px 60px rgba(0,0,0,0.12), 0 1px 0 rgba(255,255,255,0.9) inset';

// Theme-aware color palette
const themeColors = {
  dark: {
    bg: '#1a1a1a',
    bg2: '#08080e',
    bgModal: '#1a1a1a',
    text: '#fff',
    textMuted: 'rgba(255,255,255,0.5)',
    border: 'rgba(255,255,255,0.1)',
    border2: 'rgba(255,255,255,0.06)',
    borderSubtle: 'rgba(255,255,255,0.05)',
    pdfBg: '#525659',
    accentBg: 'rgba(var(--zos-accent-rgb),0.1)',
    inputBg: '#1a1a1a',
  },
  light: {
    bg: '#f5f5f5',
    bg2: '#fafafa',
    bgModal: '#ffffff',
    text: '#0f0f0f',
    textMuted: 'rgba(0,0,0,0.5)',
    border: 'rgba(0,0,0,0.12)',
    border2: 'rgba(0,0,0,0.08)',
    borderSubtle: 'rgba(0,0,0,0.05)',
    pdfBg: '#ffffff',
    accentBg: 'rgba(var(--zos-accent-rgb),0.08)',
    inputBg: '#ffffff',
  }
};

const colors = isDarkMode ? themeColors.dark : themeColors.light;

// Inject light mode CSS support
const styleEl = document.createElement('style');
styleEl.id = 'zen-os-light-mode';
styleEl.textContent = `
  body.theme-light .zos-dashboard,
  body.theme-light .zos-dashboard * {
    --card-bg: #ffffff;
    --card-border: rgba(0,0,0,0.09);
  }
  body.theme-light .zos-dashboard {
    color: #0f0f0f !important;
    background: transparent !important;
  }
  body.theme-light .zos-modal-overlay {
    background: rgba(0,0,0,0.25) !important;
    overflow: visible !important;
  }
  body.theme-dark .zos-modal-overlay {
    overflow: visible !important;
  }
  body.theme-light .zos-modal {
    background: rgba(255,255,255,0.82) !important;
    backdrop-filter: blur(32px) saturate(200%) !important;
    -webkit-backdrop-filter: blur(32px) saturate(200%) !important;
    color: #0f0f0f !important;
    border-color: rgba(0,0,0,0.07) !important;
    box-shadow: 0 20px 60px rgba(0,0,0,0.12) !important;
  }
  body.theme-dark .zos-modal {
    background: rgba(22,22,30,0.92) !important;
    backdrop-filter: blur(32px) !important;
    -webkit-backdrop-filter: blur(32px) !important;
  }
  body.theme-light .zos-modal-input,
  body.theme-light textarea.zos-modal-input,
  body.theme-light .zos-ai-input {
    background: rgba(0,0,0,0.05) !important;
    color: #0f0f0f !important;
    border-color: rgba(0,0,0,0.12) !important;
  }
  body.theme-light .zos-card {
    background: #ffffff !important;
    color: #0f0f0f !important;
    border-color: rgba(0,0,0,0.09) !important;
  }
  body.theme-light .zos-card-shell {
    background: transparent !important;
  }
  body.theme-light .zos-col-grid {
    background: transparent !important;
  }
  body.theme-light .zos-action-btn {
    background: rgba(0,0,0,0.05) !important;
    color: #1e293b !important;
    border-color: rgba(0,0,0,0.08) !important;
  }
  body.theme-light .zos-action-btn:hover {
    background: rgba(var(--zos-accent-rgb),0.08) !important;
    color: var(--zos-accent) !important;
    border-color: rgba(var(--zos-accent-rgb),0.25) !important;
  }
  body.theme-light .zos-card-title {
    color: rgba(0,0,0,0.4) !important;
  }
  body.theme-light .zos-stat-cube {
    background: rgba(255,255,255,0.92) !important;
    border-color: rgba(0,0,0,0.08) !important;
  }
  body.theme-light .zos-hero-stats .zos-stat-cube {
    background: rgba(255,255,255,0.92) !important;
    border-color: rgba(0,0,0,0.08) !important;
    color: #0f0f0f !important;
  }
  body.theme-light .zos-btn-cancel {
    background: rgba(0,0,0,0.06) !important;
    color: rgba(0,0,0,0.65) !important;
    border-color: rgba(0,0,0,0.1) !important;
  }
  body.theme-light .zos-btn-cancel:hover {
    background: rgba(0,0,0,0.1) !important;
    color: rgba(0,0,0,0.85) !important;
  }
  body.theme-light .zos-btn-save {
    background: var(--zos-accent) !important;
    color: #ffffff !important;
    border-color: var(--zos-accent) !important;
  }
  body.theme-light .zos-btn-delete {
    background: rgba(220,38,38,0.08) !important;
    color: rgba(220,38,38,0.85) !important;
    border-color: rgba(220,38,38,0.2) !important;
  }
  body.theme-light .zos-modal-title {
    color: rgba(0,0,0,0.5) !important;
    letter-spacing: 2px !important;
  }
  body.theme-light .zos-modal-btn {
    color: rgba(0,0,0,0.7) !important;
    border-color: rgba(0,0,0,0.1) !important;
  }
  body.theme-light .zos-stat-val {
    color: #0f0f0f !important;
  }
  body.theme-light .zos-stat-lab {
    color: rgba(0,0,0,0.4) !important;
  }
  body.theme-light .zos-task-source-indicator {
    background: rgba(0,0,0,0.06) !important;
    color: rgba(0,0,0,0.5) !important;
  }
  body.theme-light .zos-control-group {
    background: rgba(0,0,0,0.04) !important;
    border-color: rgba(0,0,0,0.08) !important;
  }
  body.theme-light .zos-control-label {
    color: rgba(0,0,0,0.4) !important;
  }
  body.theme-light .zos-control-value {
    color: rgba(0,0,0,0.75) !important;
  }
  body.theme-light .zos-hint {
    color: rgba(0,0,0,0.4) !important;
  }
  body.theme-light .zos-clock-card {
    color: #0f0f0f !important;
  }
  body.theme-light .zos-settings-btn,
  body.theme-light .zos-banner-settings-btn {
    color: rgba(0,0,0,0.35) !important;
  }
  body.theme-light .zos-resize-handle {
    background: rgba(0,0,0,0.04) !important;
    border-color: rgba(0,0,0,0.08) !important;
  }
  body.theme-light .zos-resize-grip {
    color: rgba(0,0,0,0.3) !important;
  }
  body.theme-light .zos-hero-stats .zos-stat-cube {
    background: rgba(255,255,255,0.92) !important;
    border-color: rgba(0,0,0,0.08) !important;
    color: #0f0f0f !important;
  }
`;
if(!document.getElementById('zen-os-light-mode')){
  document.head.appendChild(styleEl);
}

// -- PERSISTENCE -----------------
let setIcon,requestUrl;
try{const o=require("obsidian");setIcon=o.setIcon;requestUrl=o.requestUrl;}catch(e){}
if(!setIcon)setIcon=()=>{};
async function request(opts){
    const url=opts.url;
    const method=(opts.method||"GET").toUpperCase();
    const headers=opts.headers||{};
    const body=opts.body;
    if(typeof requestUrl==="function"){
        const req={url,method,headers,throw:false};
        if(body!=null)req.body=typeof body==="string"?body:JSON.stringify(body);
        const res=await requestUrl(req);
        const text=res.text!=null?String(res.text):"";
        const status=res.status||0;
        if(status>=400){
            let errMsg=text?(()=>{try{const j=JSON.parse(text);return j.error&&j.error.message?j.error.message:text.slice(0,250);}catch(_){return text.slice(0,250);}})():`HTTP ${status}`;
            if(status===429)errMsg=(errMsg||"")+" 429";
            const e=new Error(errMsg);
            e.status=status;
            throw e;
        }
        return text;
    }
    const r=await fetch(url,{method,headers,body:body!=null?(typeof body==="string"?body:JSON.stringify(body)):undefined});
    const text=await r.text();
    if(r.status>=400){
        let errMsg=text?(()=>{try{const j=JSON.parse(text);return j.error&&j.error.message?j.error.message:text.slice(0,250);}catch(_){return text.slice(0,250);}})():`HTTP ${r.status}`;
        if(r.status===429)errMsg=(errMsg||"")+" 429";
        const e=new Error(errMsg);
        e.status=r.status;
        throw e;
    }
    return text;
}

async function getWorkspaceAccessToken(){
    try{
        const gwPlugin = app?.plugins?.plugins?.["google-workspace-obsidian"];
        if(gwPlugin?.auth?.getToken){
            const t = await gwPlugin.auth.getToken();
            if(t && typeof t === "string") return t.trim();
        }
    }catch(e){}
    return (localStorage.getItem("googleDriveAccessToken") || localStorage.getItem("googleCalendarAccessToken") || "").trim();
}
// -- LOAD AI KEYS FROM VAULT -----------
async function loadAIKeysFromVault() {
    try {
        const keyFile = app.vault.getAbstractFileByPath("_config/ai-keys.md");
        if (!keyFile) return;
        const content = await app.vault.read(keyFile);
        const lines = content.split("\n");
        let githubKey = "", grokKey = "";
        for (const line of lines) {
            const trimmed = line.trim().replace(/\r/g, "").replace(/\\/g, "");
            if (trimmed.startsWith("github_key:")) githubKey = trimmed.split("github_key:")[1].trim();
            if (trimmed.startsWith("grok_key:"))   grokKey   = trimmed.split("grok_key:")[1].trim();
        }
        const providers = [];
        if (githubKey) providers.push({
            id: "github-gpt4o", label: "GitHub GPT-4o",
            key: githubKey,
            url: "https://models.inference.ai.azure.com/chat/completions",
            model: "gpt-4o", headers: {}
        });
        if (grokKey) providers.push({
            id: "grok", label: "Grok",
            key: grokKey,
            url: "https://api.x.ai/v1/chat/completions",
            model: "grok-3-mini", headers: {}
        });
        if (providers.length) {
            localStorage.setItem("zos-ai-provider-config", JSON.stringify(providers));
            console.log("ZOS: Loaded providers:", providers.map(p => p.label).join(" + "));
        }
    } catch(e) {
        console.warn("ZOS: Could not load AI keys:", e);
    }
}
await loadAIKeysFromVault();
// -- AUTO-SYNC DRIVE TOKEN FROM CALENDAR TOKEN -----
(function syncDriveToken(){
    const calTok = localStorage.getItem("googleCalendarAccessToken") || "";
    const driveTok = localStorage.getItem("googleDriveAccessToken") || "";
    if(calTok && calTok !== driveTok){
        localStorage.setItem("googleDriveAccessToken", calTok);
        console.log("ZOS: Drive token synced from calendar token ✓");
    }
})();

let doneMap     = JSON.parse(localStorage.getItem("zos-done-map")  || "{}");
let notesMap    = JSON.parse(localStorage.getItem("zos-notes-map") || "{}");
let priorityMap = JSON.parse(localStorage.getItem("zos-prio-map")  || "{}");
let bannerTitle    = localStorage.getItem("zos-banner-title")    || "DASHBOARD ZEN";
let bannerSubtitle = localStorage.getItem("zos-banner-subtitle") || "";
let selectedCals   = JSON.parse(localStorage.getItem("zos-selected-calendars") || "[]");
let pipelineView   = localStorage.getItem("zos-pipeline-view")   || "list";
let sortMode       = localStorage.getItem("zos-sort-mode")       || "date";
let activeFilter   = localStorage.getItem("zos-active-filter") || null;
const save = (k,v) => localStorage.setItem(k, typeof v==="string"?v:JSON.stringify(v));

const DEFAULT_LEFT_ORDER = ["clock","system","links","github"];
let leftOrder = JSON.parse(localStorage.getItem("zos-left-order") || "null");
if(!leftOrder || leftOrder.length === 0) leftOrder = [...DEFAULT_LEFT_ORDER];
leftOrder = leftOrder.filter(id => id !== "objective");
if(leftOrder.indexOf("links")===-1) leftOrder.push("links");
if(leftOrder.indexOf("github")===-1) leftOrder.push("github");

// -- ACCENT PRESETS ----------------
const ACCENTS = [
    { label:"Indigo",  rgb:"99,102,241",  hex:"#6366f1" },
    { label:"Cyan",    rgb:"0,229,255",   hex:"#00e5ff" },
    { label:"Emerald", rgb:"0,255,136",   hex:"#00ff88" },
    { label:"Violet",  rgb:"180,80,255",  hex:"#b450ff" },
    { label:"Amber",   rgb:"255,200,0",   hex:"#ffc800" },
    { label:"Orange",  rgb:"255,140,0",   hex:"#ff8c00" },
    { label:"Rose",    rgb:"255,85,120",  hex:"#ff5578" },
    { label:"Slate",   rgb:"226,232,240", hex:"#e2e8f0" },
];

// -- AI PROVIDERS ----------------
const AI_PROVIDERS = [
    { id:"zos-groq-key",       label:"Groq",       free:true,  badge:"Fast",    placeholder:"gsk_...",    url:"https://console.groq.com/keys",                  model:"llama-3.1-8b-instant", testUrl:"https://api.groq.com/openai/v1/chat/completions" },
    { id:"zos-gemini-key",     label:"Gemini",     free:true,  badge:"Google",  placeholder:"AIza...",    url:"https://aistudio.google.com/app/apikey",          model:"gemini-2.0-flash",      testUrl:"https://generativelanguage.googleapis.com/v1beta/openai/chat/completions" },
    { id:"zos-openrouter-key", label:"OpenRouter", free:true,  badge:"Multi",   placeholder:"sk-or-...",  url:"https://openrouter.ai/keys",                      model:"openai/gpt-4o-mini",    testUrl:"https://openrouter.ai/api/v1/chat/completions" },
    { id:"zos-openai-key",     label:"OpenAI",     free:false, badge:"GPT-4o",  placeholder:"sk-...",     url:"https://platform.openai.com/api-keys",            model:"gpt-4o-mini",           testUrl:"https://api.openai.com/v1/chat/completions" },
    { id:"zos-grok-key",       label:"Grok",       free:false, badge:"xAI",     placeholder:"xai-...",    url:"https://console.x.ai/",                           model:"grok-3-mini",           testUrl:"https://api.x.ai/v1/chat/completions" },
];

const RIGHT_DEFAULT = ["pipeline","ainews"];
let rightOrder = JSON.parse(localStorage.getItem("zos-right-order") || "null");
// Remove wizard from any saved order, ensure ainews exists
if(rightOrder) rightOrder = rightOrder.filter(id => id !== "wizard");
if(!rightOrder || rightOrder.length === 0) rightOrder = [...RIGHT_DEFAULT];
if(rightOrder.indexOf("ainews")===-1) rightOrder.splice(rightOrder.length,0,"ainews");
rightOrder = rightOrder.filter(id => id !== "ctf" && id !== "links" && id !== "github");
save("zos-right-order", rightOrder);

const GRID_COLUMN_COUNT = 4;
const DEFAULT_CARD_SPANS = {clock:4,system:4,links:4,pipeline:4,ainews:4,github:4};
const MIN_CARD_SPAN = 2;
let cardSpanMap = JSON.parse(localStorage.getItem("zos-card-span-map") || "null");
if(!cardSpanMap || typeof cardSpanMap !== "object") cardSpanMap = {...DEFAULT_CARD_SPANS};

function getCardSpan(cardId){
    const raw = Number(cardSpanMap?.[cardId]);
    if(Number.isFinite(raw)) return Math.max(MIN_CARD_SPAN, Math.min(GRID_COLUMN_COUNT, Math.round(raw)));
    return DEFAULT_CARD_SPANS[cardId] || GRID_COLUMN_COUNT;
}

function setCardSpan(cardId,span){
    cardSpanMap[cardId] = Math.max(MIN_CARD_SPAN, Math.min(GRID_COLUMN_COUNT, Math.round(span)));
    save("zos-card-span-map", cardSpanMap);
}

function applyCardSpan(cardEl,cardId,span=getCardSpan(cardId)){
    const safeSpan = Math.max(MIN_CARD_SPAN, Math.min(GRID_COLUMN_COUNT, Math.round(span)));
    cardEl.setAttribute("data-span",String(safeSpan));
    cardEl.style.gridColumn = `span ${safeSpan}`;
}

function attachResizeHandle(cardEl,cardId,getGridEl){
    const handle = cardEl.createDiv({cls:"zos-resize-handle"});
    const grip = handle.createDiv({cls:"zos-resize-grip"});
    grip.innerText = "⋮";
    handle.title = "Drag to resize";
    handle.onmousedown = e=>{
        e.preventDefault();
        e.stopPropagation();
        const gridEl = getGridEl?.();
        if(!gridEl) return;
        const gridRect = gridEl.getBoundingClientRect();
        const cardRect = cardEl.getBoundingClientRect();
        const styles = getComputedStyle(gridEl);
        const gap = parseFloat(styles.columnGap || styles.gap || "24") || 24;
        const colWidth = (gridRect.width - gap * (GRID_COLUMN_COUNT - 1)) / GRID_COLUMN_COUNT;
        const minRight = cardRect.left + colWidth * MIN_CARD_SPAN + gap * (MIN_CARD_SPAN - 1);
        const maxRight = cardRect.left + colWidth * GRID_COLUMN_COUNT + gap * (GRID_COLUMN_COUNT - 1);
        cardEl.classList.add("is-resizing");
        document.body.style.userSelect = "none";
        document.body.style.cursor = "ew-resize";

        const onMove = ev=>{
            const clampedRight = Math.max(minRight, Math.min(maxRight, ev.clientX));
            const width = clampedRight - cardRect.left;
            const span = Math.round((width + gap) / (colWidth + gap));
            applyCardSpan(cardEl, cardId, span);
        };

        const onUp = ()=>{
            document.removeEventListener("mousemove", onMove);
            document.removeEventListener("mouseup", onUp);
            document.body.style.userSelect = "";
            document.body.style.cursor = "";
            cardEl.classList.remove("is-resizing");
            setCardSpan(cardId, Number(cardEl.getAttribute("data-span")) || getCardSpan(cardId));
        };

        document.addEventListener("mousemove", onMove);
        document.addEventListener("mouseup", onUp);
    };
    return handle;
}

function isDone(ev)     { return !!doneMap[ev.id]; }
function toggleDone(ev) { doneMap[ev.id] ? delete doneMap[ev.id] : (doneMap[ev.id]=true); save("zos-done-map", doneMap); }
function getNote(ev)    { return notesMap[ev.id]||""; }
function setNote(ev,n)  { notesMap[ev.id]=n; save("zos-notes-map",notesMap); }
function getPrio(ev)    { return priorityMap[ev.id]||"NORMAL"; }
function setPrio(ev,p)  { priorityMap[ev.id]=p; save("zos-prio-map",priorityMap); }

// -- STATE -----------------------------
let calViewDate   = new Date();
let timerInterval = null;
let clockInterval = null;
let allEvents     = [], allCalendars = [];
let lastSynced    = null;
let lastSyncEl;

const container = dv.container.createDiv({ cls:"zos-dashboard animate-in", attr:{style:isDarkMode?"":"background:transparent;"} });

// -- DATE HELPERS ----------------
function getEventDate(ev){ const r=ev.start?.dateTime||ev.start?.date; return r?new Date(r):null; }
function getCalName(ev)  { return ev.parent?.summary||ev.parent?.id||"General"; }
function getDaysLeft(d)  { const n=new Date();n.setHours(0,0,0,0);const x=new Date(d);x.setHours(0,0,0,0);return Math.round((x-n)/86400000); }
function getSecsLeft(d)  { return Math.floor((d.getTime()-Date.now())/1000); }

function getGCRLink(ev) {
    const desc = ev.description || "";
    const m = desc.match(/https:\/\/classroom\.google\.com\/[^\s<>"\\]*/);
    if (m) return m[0].replace(/[\\]+$/,"").replace(/\n.*$/,"").trim();
    return ev.htmlLink || null;
}

function fmtCountdown(secs) {
    if(secs<=0) return "OVERDUE";
    const d=Math.floor(secs/86400),h=Math.floor((secs%86400)/3600),m=Math.floor((secs%3600)/60),s=secs%60;
    if(d>0) return `${d}d ${String(h).padStart(2,"0")}h ${String(m).padStart(2,"0")}m ${String(s).padStart(2,"0")}s`;
    if(h>0) return `${h}h ${String(m).padStart(2,"0")}m ${String(s).padStart(2,"0")}s`;
    return `${String(m).padStart(2,"0")}m ${String(s).padStart(2,"0")}s`;
}

function fmtDate(d) {
    const t=d.toLocaleTimeString("en-US",{hour:"2-digit",minute:"2-digit"});
    const x=d.toLocaleDateString("en-US",{weekday:"short",month:"short",day:"numeric"});
    return t==="12:00 AM"?x:`${x} · ${t}`;
}

function fmtRelative(d) {
    const dl=getDaysLeft(d);
    if(dl===0) return "Due today";
    if(dl===1) return "Tomorrow";
    if(dl>0&&dl<7) return `${dl}d left`;
    return fmtDate(d);
}

function urgencyStyle(dl,prio) {
    const lightNow = isDarkMode === false || document.body?.classList?.contains("theme-light");
    if(lightNow){
        if(prio==="HIGH"&&dl>=0) return {border:"rgba(99,102,241,0.35)",bg:"#ffffff",acc:"rgba(67,56,202,0.9)",bbg:"rgba(99,102,241,0.12)"};
        if(dl<0)   return {border:"rgba(239,68,68,0.35)",  bg:"#ffffff",acc:"rgba(220,38,38,0.92)", bbg:"rgba(239,68,68,0.1)"};
        if(dl===0) return {border:"rgba(249,115,22,0.35)", bg:"#ffffff",acc:"rgba(234,88,12,0.92)", bbg:"rgba(249,115,22,0.1)"};
        if(dl<=2)  return {border:"rgba(245,158,11,0.3)",  bg:"#ffffff",acc:"rgba(180,83,9,0.88)",  bbg:"rgba(245,158,11,0.1)"};
        if(dl<=7)  return {border:"rgba(59,130,246,0.25)", bg:"#ffffff",acc:"rgba(29,78,216,0.78)", bbg:"rgba(59,130,246,0.1)"};
        return      {border:"rgba(148,163,184,0.3)",        bg:"#ffffff",acc:"rgba(71,85,105,0.72)", bbg:"rgba(148,163,184,0.1)"};
    }
    if(prio==="HIGH"&&dl>=0) return {border:"rgba(255,255,255,0.15)",bg:"rgba(255,255,255,0.03)",acc:"rgba(255,255,255,0.7)",bbg:"rgba(255,255,255,0.07)"};
    if(dl<0)   return {border:"rgba(255,255,255,0.15)",bg:"rgba(255,255,255,0.03)",acc:"rgba(255,255,255,0.6)",bbg:"rgba(255,255,255,0.07)"};
    if(dl===0) return {border:"rgba(255,255,255,0.15)",bg:"rgba(255,255,255,0.03)",acc:"rgba(255,255,255,0.7)",bbg:"rgba(255,255,255,0.07)"};
    if(dl<=2)  return {border:"rgba(255,255,255,0.1)", bg:"rgba(255,255,255,0.02)",acc:"rgba(255,255,255,0.6)",bbg:"rgba(255,255,255,0.06)"};
    if(dl<=7)  return {border:"rgba(255,255,255,0.07)",bg:"rgba(255,255,255,0.01)",acc:"rgba(255,255,255,0.45)",bbg:"rgba(255,255,255,0.04)"};
    return      {border:"rgba(255,255,255,0.05)",bg:"transparent",acc:"rgba(255,255,255,0.3)",bbg:"rgba(255,255,255,0.03)"};
}

function timerColor(secs) {
    if(secs<=0)     return isDarkMode ? "rgba(255,255,255,0.25)" : "rgba(220,38,38,0.7)";
    if(secs<3600)   return isDarkMode ? "#ff5555" : "#dc2626";
    if(secs<86400)  return isDarkMode ? "#ff8c00" : "#c96a00";
    if(secs<259200) return isDarkMode ? "#ffc800" : "#a86800";
    return "var(--zos-accent)";
}

// -- MODAL -----------------------------
function modal({title,type="text",value="",placeholder="",options=[],selected=[],onSave,onDelete}){
    const ov=document.body.createDiv({cls:"zos-modal-overlay"});
    const mo=ov.createDiv({cls:"zos-modal",attr:{style:`background:${modalBg};${modalBlur}color:${modalText};border-color:${modalBorder};box-shadow:${modalShadow};`}});
    mo.createDiv({cls:"zos-modal-title",attr:{style:`color:${modalText};`},text:title});
    const cl=()=>ov.remove();
    ov.onclick=e=>{if(e.target===ov)cl();};

    const inpStyle=`width:100%;background:${isDarkMode?'rgba(255,255,255,0.06)':'rgba(0,0,0,0.05)'};border:1px solid ${isDarkMode?'rgba(255,255,255,0.1)':'rgba(0,0,0,0.12)'};border-radius:11px;padding:12px 14px;color:${modalText};font-family:var(--zos-font-main);font-size:0.88em;outline:none;box-sizing:border-box;transition:border-color 0.2s;margin-bottom:14px;`;

    if(type==="text"){
        const inp=mo.createEl("input",{cls:"zos-modal-input",attr:{type:"text",value,placeholder:placeholder||"Type here...",style:inpStyle}});
        inp.onfocus=()=>{inp.style.borderColor="var(--zos-accent)";};
        inp.onblur=()=>{inp.style.borderColor=isDarkMode?'rgba(255,255,255,0.1)':'rgba(0,0,0,0.12)';};
        inp.focus();inp.select();
        const row=mo.createDiv({cls:"zos-modal-btns"}).createDiv({cls:"zos-modal-row"});
        row.createEl("button",{cls:"zos-modal-btn zos-btn-cancel",text:"Cancel"}).onclick=cl;
        const sv=row.createEl("button",{cls:"zos-modal-btn zos-btn-save",text:"Save"});
        sv.onclick=()=>{onSave(inp.value);cl();};
        inp.onkeydown=e=>{if(e.key==="Enter")sv.click();if(e.key==="Escape")cl();};
        if(onDelete) mo.createEl("button",{cls:"zos-modal-btn zos-btn-delete",text:"Delete",attr:{style:"width:100%;margin-top:8px;"}}).onclick=()=>{onDelete();cl();};
    }else if(type==="textarea"){
        const ta=mo.createEl("textarea",{attr:{rows:"4",placeholder,style:`width:100%;background:${isDarkMode?'rgba(255,255,255,0.05)':'rgba(0,0,0,0.04)'};border:1px solid ${isDarkMode?'rgba(255,255,255,0.1)':'rgba(0,0,0,0.12)'};border-radius:12px;padding:14px;color:${modalText};font-family:var(--zos-font-main);font-size:0.9em;outline:none;margin-bottom:20px;resize:vertical;box-sizing:border-box;`}});
        ta.value=value;ta.focus();
        const row=mo.createDiv({cls:"zos-modal-btns"}).createDiv({cls:"zos-modal-row"});
        row.createEl("button",{cls:"zos-modal-btn zos-btn-cancel",text:"Cancel"}).onclick=cl;
        row.createEl("button",{cls:"zos-modal-btn zos-btn-save",text:"Save Note"}).onclick=()=>{onSave(ta.value);cl();};
    }else if(type==="grid"){
        const gridBgBase = isDarkMode?'rgba(255,255,255,0.05)':'rgba(0,0,0,0.04)';
        const gridBorder = isDarkMode?'rgba(255,255,255,0.1)':'rgba(0,0,0,0.1)';
        const gc=mo.createDiv({attr:{style:"display:grid;grid-template-columns:1fr;gap:10px;margin-bottom:20px;"}});
        options.forEach(o=>{
            const b=gc.createEl("button",{cls:"zos-modal-btn",text:o.label,attr:{style:`background:${gridBgBase};color:${modalText};border:1px solid ${gridBorder};text-align:left;padding:14px;font-weight:600;`}});
            b.onclick=()=>{onSave(o.value);cl();};
            b.onmouseenter=()=>{b.style.background='rgba(var(--zos-accent-rgb),0.1)';b.style.borderColor='var(--zos-accent)';b.style.color='var(--zos-accent)';};
            b.onmouseleave=()=>{b.style.background=gridBgBase;b.style.borderColor=gridBorder;b.style.color=modalText;};
        });
        mo.createEl("button",{cls:"zos-modal-btn zos-btn-cancel",text:"Close",attr:{style:"width:100%"}}).onclick=cl;
    }else if(type==="multicheck"){
        const srch=mo.createEl("input",{attr:{placeholder:"Search calendars...",style:`width:100%;background:${isDarkMode?'rgba(255,255,255,0.05)':'rgba(0,0,0,0.04)'};border:1px solid ${isDarkMode?'rgba(255,255,255,0.08)':'rgba(0,0,0,0.1)'};border-radius:10px;padding:10px 14px;color:${modalText};font-size:0.85em;outline:none;margin-bottom:12px;box-sizing:border-box;`}});
        const list=mo.createDiv({attr:{style:"max-height:300px;overflow-y:auto;display:grid;gap:6px;margin-bottom:16px;"}});
        const ck=new Set(selected);
        const checkboxBorder=isDarkMode?'rgba(255,255,255,0.2)':'rgba(0,0,0,0.2)';
        const renderList=(f="")=>{
            list.innerHTML="";
            options.filter(o=>o.label.toLowerCase().includes(f.toLowerCase())).forEach(o=>{
                const r=list.createDiv({attr:{style:`display:flex;align-items:center;gap:10px;padding:10px 12px;background:${isDarkMode?'rgba(255,255,255,0.03)':'rgba(0,0,0,0.03)'};border-radius:10px;cursor:pointer;border:1px solid transparent;transition:all 0.15s;`}});
                const on=ck.has(o.value);
                const box=r.createDiv({attr:{style:`width:16px;height:16px;border-radius:4px;border:2px solid ${on?"var(--zos-accent)":checkboxBorder};background:${on?"var(--zos-accent)":"transparent"};flex-shrink:0;display:flex;align-items:center;justify-content:center;font-size:10px;color:#fff;`}});
                if(on)box.innerText="✓";
                r.createDiv({text:o.label,attr:{style:`font-size:0.84em;font-weight:600;color:${modalText};`}});
                r.onclick=()=>{
                    if(ck.has(o.value)){ck.delete(o.value);box.style.background="transparent";box.style.borderColor=checkboxBorder;box.innerText="";r.style.borderColor="transparent";}
                    else{ck.add(o.value);box.style.background="var(--zos-accent)";box.style.borderColor="var(--zos-accent)";box.innerText="✓";r.style.borderColor="var(--zos-accent)";}
                };
            });
        };
        srch.oninput=()=>renderList(srch.value);
        renderList();srch.focus();
        const br=mo.createDiv({cls:"zos-modal-row"});
        br.createEl("button",{cls:"zos-modal-btn zos-btn-cancel",text:"Cancel"}).onclick=cl;
        br.createEl("button",{cls:"zos-modal-btn zos-btn-save",text:"Apply"}).onclick=()=>{onSave([...ck]);cl();};
        mo.createEl("button",{cls:"zos-modal-btn",text:"Show All",attr:{style:`width:100%;margin-top:8px;background:${isDarkMode?'rgba(255,255,255,0.03)':'rgba(0,0,0,0.03)'};color:${isDarkMode?'rgba(255,255,255,0.4)':'rgba(0,0,0,0.4)'};border:1px dashed ${isDarkMode?'rgba(255,255,255,0.08)':'rgba(0,0,0,0.1)'};`}}).onclick=()=>{onSave([]);cl();};
    }
}

function greeting(){ const h=new Date().getHours();if(h<5)return"Night of Stillness ·";if(h<12)return"Morning Clarity ·";if(h<18)return"Deep Focus ·";return"End of Day ·"; }

const AI_GUARD={
    cooldownPrefix:"zos-ai-cooldown-until-",
    lastReqKey:"zos-ai-last-request-at",
    minGapMs:12000,
    defaultCooldownMs:30*60*1000,
    inFlight:new Map()
};
function setAIProviderCooldown(providerId,ms=AI_GUARD.defaultCooldownMs){
    localStorage.setItem(`${AI_GUARD.cooldownPrefix}${providerId}`,String(Date.now()+Math.max(1000,ms)));
}
function getAIGapWaitMs(){
    const last=Number(localStorage.getItem(AI_GUARD.lastReqKey)||"0");
    return Math.max(0,AI_GUARD.minGapMs-(Date.now()-last));
}
function fmtAIWait(ms){
    const secs=Math.max(1,Math.ceil(ms/1000));
    if(secs<90)return `${secs}s`;
    return `~${Math.ceil(secs/60)} min`;
}
function parseAIWaitError(msg,prefix){
    const m=String(msg||"").match(new RegExp(`^${prefix}:(\\d+)$`));
    return m?Number(m[1]):0;
}
async function validateAIKey(provider, key){
    try {
        const isGemini = provider.id==="zos-gemini-key";
        if(isGemini){
            // Use Gemini native API for validation
            const testUrl = `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-lite:generateContent?key=${encodeURIComponent(key)}`;
            try{
                const resp = await request({
                    url: testUrl,
                    method: "POST",
                    headers: {"Content-Type":"application/json"},
                    body: JSON.stringify({contents:[{parts:[{text:"hi"}]}]})
                });
                const data = JSON.parse(resp || "{}");
                if(data.candidates) return { ok:true };
                if(data.error){
                    const msg=String(data.error.message||"");
                    if(msg.includes("429")||msg.includes("quota")||msg.includes("rate")) return { ok:true };
                    return { ok:false, msg: data.error.message||"Invalid key" };
                }
                return { ok:false, msg:"Unexpected response" };
            }catch(e){
                const msg=String(e.message||"");
                if(msg.includes("429")||msg.includes("quota")||msg.includes("rate")) return { ok:true };
                throw e;
            }
        }
        const headers = {"Content-Type":"application/json","Authorization":`Bearer ${key}`};
        if(provider.id==="zos-openrouter-key"){
            headers["HTTP-Referer"] = "https://obsidian.md";
            headers["X-Title"] = "ZEN-OS Dashboard";
        }
        const resp = await request({
            url: provider.testUrl,
            method: "POST",
            headers,
            body: JSON.stringify({model:provider.model,max_tokens:5,messages:[{role:"user",content:"hi"}]})
        });
        const data = JSON.parse(resp || "{}");
        if(data.error) return { ok:false, msg: data.error.message||"Invalid key" };
        if(data.choices) return { ok:true };
        return { ok:false, msg:"Unexpected response" };
    } catch(e) {
        return { ok:false, msg: e.message||"Network error" };
    }
}
function getAIProviders(){
    const providers=[];
    const add=(id,label,keyStorage,url,model,extraHeaders)=>{
        const key=(localStorage.getItem(keyStorage)||"").trim();
        if(!key)return;
        providers.push({id,label,key,url,model,extraHeaders:extraHeaders||{}});
    };
    add("groq","Groq","zos-groq-key","https://api.groq.com/openai/v1/chat/completions","llama-3.1-8b-instant");
    add("gemini","Gemini","zos-gemini-key","https://generativelanguage.googleapis.com/v1beta/openai/chat/completions","gemini-2.0-flash");
    add("geminiLite","Gemini Lite","zos-gemini-key","https://generativelanguage.googleapis.com/v1beta/openai/chat/completions","gemini-2.0-flash-lite");
    add("openai","OpenAI","zos-openai-key","https://api.openai.com/v1/chat/completions","gpt-4o-mini");
    add("openrouter","OpenRouter","zos-openrouter-key","https://openrouter.ai/api/v1/chat/completions","openai/gpt-4o-mini",{"HTTP-Referer":"https://obsidian.md","X-Title":"Zen OS Dashboard"});
    add("together","Together","zos-together-key","https://api.together.xyz/v1/chat/completions","meta-llama/Llama-3.1-8B-Instruct-Turbo");
    try{
        const custom=JSON.parse(localStorage.getItem("zos-ai-provider-config")||"[]");
        if(Array.isArray(custom)){
            custom.forEach((p,i)=>{
                if(!p||!p.url||!p.key||!p.model)return;
                providers.push({
                    id:p.id||`custom${i+1}`,
                    label:p.label||`Custom ${i+1}`,
                    key:String(p.key),
                    url:String(p.url),
                    model:String(p.model),
                    extraHeaders:(p.headers&&typeof p.headers==="object")?p.headers:{}
                });
            });
        }
    }catch(e){}
    return providers;
}
async function guardedAIRequest(scope,body){
    const gapWait=getAIGapWaitMs();
    if(gapWait>0)throw new Error(`AI_GAP:${gapWait}`);
    const providers=getAIProviders();
    if(!providers.length)throw new Error("AI_NO_PROVIDER:Set zos-openai-key or zos-gemini-key or zos-openrouter-key or zos-groq-key or zos-together-key");
    if(AI_GUARD.inFlight.has(scope))return await AI_GUARD.inFlight.get(scope);
    const p=(async()=>{
        let lastErr="request failed";
        const attempts=[];
        try{
            for(const provider of providers){
                localStorage.setItem(AI_GUARD.lastReqKey,String(Date.now()));
                try{
                    const reqBody={...body,model:provider.model};
                    const isGemini=provider.id==="gemini"||provider.id==="geminiLite";
                    let reqUrl=provider.url;
                    const reqHeaders={"Content-Type":"application/json",...provider.extraHeaders};
                    if(isGemini){
                        reqUrl=reqUrl+(reqUrl.includes("?")?"&":"?")+"key="+encodeURIComponent(provider.key);
                    }
                    reqHeaders["Authorization"]=`Bearer ${provider.key}`;
                    const resp=await request({
                        url:reqUrl,
                        method:"POST",
                        headers:reqHeaders,
                        body:JSON.stringify(reqBody)
                    });
                    const data=JSON.parse(resp||"{}");
                    if(data.error?.message){
                        const emsg=String(data.error.message);
                        if(emsg.includes("429"))setAIProviderCooldown(provider.id);
                        lastErr=`${provider.label}: ${emsg}`;
                        attempts.push(lastErr);
                        continue;
                    }
                    data._provider=provider.label;
                    return data;
                }catch(e){
                    const msg=(e?.message||"request failed").toString();
                    if(msg.includes("429"))setAIProviderCooldown(provider.id);
                    lastErr=`${provider.label}: ${msg}`;
                    attempts.push(lastErr);
                    continue;
                }
            }
            const detail=(attempts.length?attempts.join(" | "):lastErr).slice(0,420);
            throw new Error(`AI_ALL_PROVIDERS_FAILED:${detail}`);
        }finally{
            AI_GUARD.inFlight.delete(scope);
        }
    })();
    AI_GUARD.inFlight.set(scope,p);
    return await p;
}

function openAskAIAnswerModal(question,answer,providerLabel="AI"){
    // Build initial chat history
    const chatHistory=[
        {role:"user",content:question},
        {role:"assistant",content:answer,provider:providerLabel}
    ];

    const ov=document.body.createDiv({cls:"zos-modal-overlay"});
    const chatModalBg = isDarkMode ? '#1a1a1a' : '#ffffff';
    const chatBorder = isDarkMode ? 'rgba(255,255,255,0.06)' : 'rgba(0,0,0,0.06)';
    const chatText = isDarkMode ? '#fff' : '#0f0f0f';
    const chatBubbleBgOther = isDarkMode ? 'rgba(255,255,255,0.04)' : 'rgba(0,0,0,0.04)';
    const chatBubbleBorderOther = isDarkMode ? 'rgba(255,255,255,0.07)' : 'rgba(0,0,0,0.07)';
    const mo=ov.createDiv({cls:"zos-modal",attr:{style:`width:min(780px,92vw);max-height:88vh;display:flex;flex-direction:column;padding:0;overflow:hidden;background:${modalBg};${modalBlur}color:${modalText};border-color:${modalBorder};box-shadow:${modalShadow};`}});
    const close=()=>ov.remove();
    ov.onclick=e=>{if(e.target===ov)close();};

    // -- HEADER ----------------
    const hdr=mo.createDiv({attr:{style:`display:flex;align-items:center;justify-content:space-between;padding:16px 20px 12px;border-bottom:1px solid ${chatBorder};flex-shrink:0;`}});
    hdr.createDiv({attr:{style:`font-size:0.72em;font-weight:800;letter-spacing:2px;opacity:0.5;color:${chatText};`}}).innerText="AI CHAT";
    const providerBadge=hdr.createDiv({attr:{style:"font-size:0.6em;font-weight:700;padding:2px 8px;border-radius:20px;background:rgba(var(--zos-accent-rgb),0.1);color:var(--zos-accent);font-family:var(--zos-font-mono);"}});
    providerBadge.innerText=providerLabel;
    const closeBtn=hdr.createDiv({attr:{style:`font-size:0.8em;opacity:0.3;cursor:pointer;padding:4px 8px;border-radius:6px;transition:all 0.2s;color:${chatText};`}});
    closeBtn.innerText="✕";
    closeBtn.onmouseenter=()=>{closeBtn.style.opacity="1";closeBtn.style.background="rgba(255,85,85,0.15)";closeBtn.style.color="#ff5555";};
    closeBtn.onmouseleave=()=>{closeBtn.style.opacity="0.3";closeBtn.style.background="";closeBtn.style.color=chatText;};
    closeBtn.onclick=close;

    // -- MESSAGES AREA -------------
    const msgArea=mo.createDiv({attr:{style:`flex:1;overflow-y:auto;padding:16px 20px;display:flex;flex-direction:column;gap:14px;min-height:0;background:${chatModalBg};`}});

    const renderMessage=(role,content,provider)=>{
        const isUser=role==="user";
        const wrap=msgArea.createDiv({attr:{style:"display:flex;flex-direction:column;align-items:"+(isUser?"flex-end":"flex-start")+";gap:4px;"}});
        const bubble=wrap.createDiv({attr:{style:`max-width:85%;padding:10px 14px;border-radius:`+(isUser?"14px 14px 4px 14px":"14px 14px 14px 4px")+`;background:`+(isUser?"rgba(var(--zos-accent-rgb),0.15)":chatBubbleBgOther)+`;border:1px solid `+(isUser?"rgba(var(--zos-accent-rgb),0.25)":chatBubbleBorderOther)+`;font-size:0.8em;line-height:1.6;color:${chatText};`}});
        if(isUser){
            bubble.innerText=content;
        } else {
            renderAISummaryOutput(bubble,content);
        }
        if(!isUser&&provider){
            const provWrap=wrap.createDiv({attr:{style:"font-size:0.58em;opacity:0.25;font-family:var(--zos-font-mono);padding:0 4px;"}});
            provWrap.innerText="↳ "+provider;
        }
        return wrap;
    };

    // Render initial messages
    chatHistory.forEach(msg=>renderMessage(msg.role,msg.content,msg.provider));
    setTimeout(()=>{msgArea.scrollTop=msgArea.scrollHeight;},50);

    // -- TYPING INDICATOR ------------
    const addTypingIndicator=()=>{
        const wrap=msgArea.createDiv({attr:{style:"display:flex;align-items:flex-start;gap:4px;"}});
        const bubble=wrap.createDiv({attr:{style:`padding:10px 16px;border-radius:14px 14px 14px 4px;background:${chatBubbleBgOther};border:1px solid ${chatBubbleBorderOther};display:flex;gap:5px;align-items:center;`}});
        const typingColor = isDarkMode ? 'rgba(255,255,255,0.4)' : 'rgba(0,0,0,0.4)';
        [0,0.2,0.4].forEach(delay=>{
            const dot=bubble.createDiv({attr:{style:`width:6px;height:6px;border-radius:50%;background:${typingColor};animation:zos-dot-pulse 1.2s ease-in-out ${delay}s infinite;`}});
        });
        msgArea.scrollTop=msgArea.scrollHeight;
        return wrap;
    };

    // -- INPUT AREA --------------
    const inputBorder = isDarkMode ? 'rgba(255,255,255,0.06)' : 'rgba(0,0,0,0.06)';
    const inputBg = isDarkMode ? 'rgba(255,255,255,0.03)' : 'rgba(0,0,0,0.03)';
    const inputBgBorder = isDarkMode ? 'rgba(255,255,255,0.08)' : 'rgba(0,0,0,0.08)';
    const inputArea=mo.createDiv({attr:{style:`flex-shrink:0;padding:12px 16px;border-top:1px solid ${inputBorder};background:${chatModalBg};`}});
    const inputRow=inputArea.createDiv({attr:{style:`display:flex;align-items:center;gap:8px;background:${inputBg};border:1px solid ${inputBgBorder};border-radius:12px;padding:6px 6px 6px 14px;transition:all 0.2s;`}});
    const chatInput=inputRow.createEl("input",{cls:"zos-ai-input",attr:{type:"text",placeholder:"Ask a follow-up question...",style:`flex:1;background:transparent;border:none;color:${chatText};font-size:0.8em;outline:none;font-family:var(--zos-font-main);padding:6px 0;`}});
    const sendBtn=inputRow.createEl("button",{attr:{style:"padding:7px 14px;border-radius:9px;background:rgba(var(--zos-accent-rgb),0.15);color:var(--zos-accent);border:1px solid rgba(var(--zos-accent-rgb),0.3);font-size:0.72em;font-weight:700;cursor:pointer;transition:all 0.2s;white-space:nowrap;letter-spacing:0.5px;"}});
    sendBtn.innerText="Send ⏎";
    chatInput.onfocus=()=>{inputRow.style.borderColor="rgba(var(--zos-accent-rgb),0.35)";};
    chatInput.onblur=()=>{inputRow.style.borderColor=inputBgBorder;};
    sendBtn.onmouseenter=()=>{sendBtn.style.background="rgba(var(--zos-accent-rgb),0.25)";};
    sendBtn.onmouseleave=()=>{sendBtn.style.background="rgba(var(--zos-accent-rgb),0.15)";};
    chatInput.focus();

    // -- SEND FOLLOW-UP ------------
    const sendFollowUp=async()=>{
        const q=(chatInput.value||"").trim();
        if(!q)return;
        chatInput.value="";
        sendBtn.innerText="●  ●  ●";
        sendBtn.style.pointerEvents="none";
        chatInput.disabled=true;

        // Add user message
        chatHistory.push({role:"user",content:q});
        renderMessage("user",q);

        // Add typing indicator
        const typing=addTypingIndicator();

        try{
            // Build messages array with full history
            const now=new Date();
            const tS=new Date(now);tS.setHours(0,0,0,0);
            const tE=new Date(tS);tE.setHours(23,59,59,999);
            const wE=new Date(tS.getTime()+7*86400000);
            const pending=allEvents.filter(ev=>!isDone(ev));
            const todayEvs=pending.filter(ev=>{const d=getEventDate(ev);return d&&d>=tS&&d<=tE;});
            const weekEvs=pending.filter(ev=>{const d=getEventDate(ev);return d&&d>tE&&d<=wE;});
            const overdueEvs=pending.filter(ev=>{const d=getEventDate(ev);return d&&d<tS;});
            const fmtEv=ev=>{
                const d=getEventDate(ev);
                const dl=d?getDaysLeft(d):null;
                const status=dl===null?"no date":dl<0?"OVERDUE":dl===0?"TODAY":dl===1?"TOMORROW":dl+"d left";
                return "- "+((ev.summary||"").replace(/^Assignment:\s*/i,"").trim())+" ["+getCalName(ev)+"] ("+status+")";
            };
            let context="TODAY: "+now.toDateString()+"\n\n";

            // Assignments
            if(overdueEvs.length)context+="OVERDUE ASSIGNMENTS:\n"+overdueEvs.map(fmtEv).join("\n")+"\n\n";
            if(todayEvs.length)context+="DUE TODAY:\n"+todayEvs.map(fmtEv).join("\n")+"\n\n";
            if(weekEvs.length)context+="DUE THIS WEEK:\n"+weekEvs.map(fmtEv).join("\n")+"\n\n";
            const laterEvs=pending.filter(ev=>{const d=getEventDate(ev);return d&&d>wE;});
            if(laterEvs.length)context+="COMING UP LATER:\n"+laterEvs.map(fmtEv).join("\n")+"\n\n";
            const doneEvs2=allEvents.filter(ev=>isDone(ev));
            if(doneEvs2.length)context+="COMPLETED ASSIGNMENTS ("+doneEvs2.length+"):\n"+doneEvs2.slice(0,5).map(fmtEv).join("\n")+"\n\n";
            const highEvs2=pending.filter(ev=>getPrio(ev)==="HIGH");
            if(highEvs2.length)context+="HIGH PRIORITY:\n"+highEvs2.map(fmtEv).join("\n")+"\n\n";

            // AI News data
            try{
                const newsCached=localStorage.getItem("zos-ainews-cache");
                if(newsCached){
                    const newsArticles=JSON.parse(newsCached);
                    const srcMap={hn:"Hacker News",verge:"The Verge",techcrunch:"TechCrunch"};
                    if(newsArticles.length)context+="LATEST AI NEWS:\n"+newsArticles.slice(0,15).map(a=>"- "+a.title+" ["+( srcMap[a.source]||a.source)+"] ("+new Date(a.date).toLocaleDateString()+")").join("\n")+"\n\n";
                }
            }catch(e){}

            // Vault structure
            try{
                const allFiles=app.vault.getMarkdownFiles();
                context+="VAULT STRUCTURE ("+allFiles.length+" notes):\n";
                const folderMap={};
                allFiles.forEach(f=>{
                    const folder=f.parent?.path||"/";
                    if(!folderMap[folder])folderMap[folder]=[];
                    folderMap[folder].push(f.basename);
                });
                Object.entries(folderMap).slice(0,15).forEach(([folder,files])=>{
                    context+="  "+folder+"/: "+files.slice(0,5).join(", ")+(files.length>5?" +"+( files.length-5)+" more":"")+"\n";
                });
                context+="\n";
            }catch(e){}

            // Current objective
            const objective=localStorage.getItem("zos-focus")||"";
            if(objective&&objective!=="Define your success today...")context+="TODAY'S OBJECTIVE: "+objective+"\n\n";

            // Build messages with history
            // -- VAULT SEARCH HELPER (defined here to ensure availability) --
            const searchVaultFilesInline=async(query)=>{
                const allVaultFiles=app.vault.getMarkdownFiles();
                const searchResults=[];
                const keywords=query.toLowerCase().split(" ").filter(w=>w.length>1);
                for(const file of allVaultFiles){
                    try{
                        const text=await app.vault.cachedRead(file);
                        const textLower=text.toLowerCase();
                        const anyMatch=keywords.some(kw=>textLower.includes(kw));
                        if(!anyMatch)continue;
                        const lines=text.split("\n");
                         const matchIdxs=[];
                        lines.forEach((l,i)=>{if(keywords.some(kw=>l.toLowerCase().includes(kw)))matchIdxs.push(i);});
                        const contextSet=new Set();
                        matchIdxs.forEach(i=>{for(let j=Math.max(0,i-2);j<=Math.min(lines.length-1,i+3);j++)contextSet.add(j);});
                        const snippet=[...contextSet].sort((a,b)=>a-b).map(i=>lines[i]).filter(l=>l.trim()).join("\n");
                        if(snippet)searchResults.push({path:file.path,matches:snippet.slice(0,600)});
                    }catch(e){}
                    if(searchResults.length>=8)break;
                }
                return searchResults;
            };

            // -- PRE-SEARCH: always search vault for personal/specific queries --
            // Search vault for almost everything - names, roll nos, content questions
            const noSearchNeeded=["hello","hi","hey","thanks","ok","okay","yes","no","bye"].includes(q.toLowerCase().trim());
            const shouldSearch=!noSearchNeeded;
            let vaultSearchContext="";
            if(shouldSearch){
                // Extract best search term from question
                const stopWords=new Set(["what","is","are","the","a","an","of","in","my","me","for","to","it","its","this","that","do","does","did","how","who","where","when","and","or","tell","give","show","find","search","please","can","you"]);
                const searchTerms=q.toLowerCase().replace(/[?!.,'"]/g,"").split(" ").filter(w=>w.length>1&&!stopWords.has(w));
                const searchQuery=searchTerms.join(" ")||q.toLowerCase().slice(0,30);
                console.log("ZOS: Searching vault for:", searchQuery, "| terms:", searchTerms);
                const searchResults=await searchVaultFilesInline(searchQuery);
                if(searchResults.length>0){
                    vaultSearchContext="\n\nRELEVANT VAULT CONTENT (searched for: '"+searchQuery+"'):\n"+searchResults.map(r=>"["+r.path+"]\n"+r.matches).join("\n---\n");
                }
            }

            const messages=[
                {role:"system",content:[
                    "You are an elite AI assistant deeply integrated into the user's personal Obsidian vault and academic dashboard.",
                    "You have DIRECT ACCESS to their notes, class lists, roll numbers, assignments, CTFs, and all vault content.",
                    "",
                    "CRITICAL RULES - NEVER BREAK THESE:",
                    "1. NEVER say 'I dont have access' or 'I cannot find' - you have vault search results above, USE THEM.",
                    "2. For tables (markdown | col | format): scan EVERY row to find exact matches.",
                    "3. For roll numbers/names: find the exact row in the table and return the value.",
                    "4. If vault search results are provided, they contain the REAL answer - extract it precisely.",
                    "5. Be direct and confident. No filler. No disclaimers.",
                    "6. Remember the full conversation history.",
                    "7. For create/action requests: confirm what you did.",
                    "",
                    "DASHBOARD DATA:",
                    context,
                    vaultSearchContext?"=== VAULT SEARCH RESULTS (EXTRACT ANSWER FROM HERE) ==="+vaultSearchContext+"=== END VAULT RESULTS ===":"NO VAULT RESULTS",
                    "",
                    "STYLE: Sharp, direct, like a genius friend who has read all your notes."
                ].filter(Boolean).join("\n")}
            ];
            // Add chat history (skip system-like metadata)
            chatHistory.slice(0,-1).forEach(msg=>{
                messages.push({role:msg.role,content:msg.content});
            });
            // Add latest user message
            messages.push({role:"user",content:q});

            // Add action capability to system prompt
            const actionInstructions=[
                "You can perform real actions by ending your response with a JSON block like:",
                'ACTION:{"type":"create_note","path":"FolderName/NoteName","content":"Note content"}',
                "Available actions:",
                "- create_note: {type, path, content} - creates a note",
                "- search_vault: {type, query} - search inside all notes and get content",
                "- mark_done: {type, event_id}",
                "- set_priority: {type, event_id, priority} (HIGH or NORMAL)",
                "IMPORTANT for create_note: use exact folder names from VAULT STRUCTURE.",
                "IMPORTANT: If user asks about something that might be in their notes, use search_vault FIRST before answering.",
                "For search_vault, pick a short 1-3 word query. Put ACTION on its own line at the very end."
            ].join("\n");

            // -- VAULT SEARCH HELPER -----------
            const searchVaultFiles=async(query)=>{
                const files=app.vault.getMarkdownFiles();
                const results=[];
                // Split into individual keywords and search for any of them
                const keywords=query.toLowerCase().split(/\s+/).filter(w=>w.length>2);
                const primaryWord=keywords[0]||query.toLowerCase();
                for(const file of files){
                    try{
                        const text=await app.vault.cachedRead(file);
                        const textLower=text.toLowerCase();
                        // Check if ANY keyword matches
                        const anyMatch=keywords.some(kw=>textLower.includes(kw));
                        if(!anyMatch)continue;
                        const lines=text.split(/\r?\n/);
                        // Get lines that match ANY keyword
                        const matchLines=lines.filter(l=>{
                            const ll=l.toLowerCase();
                            return keywords.some(kw=>ll.includes(kw));
                        });
                        if(matchLines.length>0){
                            // Include surrounding context (table rows, nearby lines)
                            const allMatchIdx=[];
                            lines.forEach((l,i)=>{
                                const ll=l.toLowerCase();
                                if(keywords.some(kw=>ll.includes(kw)))allMatchIdx.push(i);
                            });
                            // Get matched lines + 1 line before and after for context
                            const contextLines=new Set();
                            allMatchIdx.forEach(i=>{
                                for(let j=Math.max(0,i-1);j<=Math.min(lines.length-1,i+1);j++)contextLines.add(j);
                            });
                            const snippet=[...contextLines].sort((a,b)=>a-b).map(i=>lines[i].trim()).filter(Boolean).slice(0,8).join("\n");
                            results.push({path:file.path,matches:snippet});
                        }
                    }catch(e){}
                    if(results.length>=10)break;
                }
                return results;
            };
            messages[0].content+="\n\n"+actionInstructions;

            const data=await guardedAIRequest("chat-followup-"+Date.now(),{
                max_tokens:800,
                messages:messages
            });
            let reply=data?.choices?.[0]?.message?.content?.trim()||"No response.";
            const provider=data?._provider||"AI";

            // Parse ACTION line
            let actionResult="";
            const actionLine=reply.match(/ACTION:({.*})/);
            if(actionLine){
                reply=reply.replace(actionLine[0],"").trim();
                try{
                    const action=JSON.parse(actionLine[1]);
                    if(action.type==="create_note"){
                        // Support full path in title like "Folder/Subfolder/Note Name"
                        let notePath=action.path||action.title;
                        if(!notePath.endsWith(".md"))notePath+=".md";
                        // If no folder in path, use default folder
                        if(!notePath.includes("/")){
                            const defaultFolder=localStorage.getItem("zos-default-note-folder")||"";
                            if(defaultFolder)notePath=defaultFolder+"/"+notePath;
                        }
                        // Create parent folders if needed
                        const parts=notePath.split("/");
                        if(parts.length>1){
                            let folderPath="";
                            for(let i=0;i<parts.length-1;i++){
                                folderPath=folderPath?(folderPath+"/"+parts[i]):parts[i];
                                const existing=app.vault.getAbstractFileByPath(folderPath);
                                if(!existing){
                                    try{await app.vault.createFolder(folderPath);}catch(e){}
                                }
                            }
                        }
                        const existing=app.vault.getAbstractFileByPath(notePath);
                        if(existing){
                            await app.vault.modify(existing,action.content||"");
                            actionResult="\n\n✅ Updated note at: "+notePath;
                        }else{
                            await app.vault.create(notePath,action.content||"");
                            actionResult="\n\n✅ Created note at: "+notePath;
                        }
                    }else if(action.type==="search_vault"){
                        const searchResults=await searchVaultFiles(action.query||"");
                        if(searchResults.length){
                            const resultText=searchResults.map(r=>"["+r.path+"] "+r.matches).join("\n");
                            // Do a second AI call with the search results
                            const searchMessages=[
                                {role:"system",content:"You are a helpful assistant with access to the user's notes. Answer their question DIRECTLY using the search results. If it's a table with names/roll numbers, extract the exact value. Do not say you cannot find it if it appears in the results.\n\nSEARCH RESULTS for '"+action.query+"':\n"+resultText},
                                {role:"user",content:q}
                            ];
                            const searchData=await guardedAIRequest("vault-search-"+Date.now(),{
                                max_tokens:400,
                                messages:searchMessages
                            });
                            const searchReply=searchData?.choices?.[0]?.message?.content?.trim()||"";
                            if(searchReply)actionResult="\n\n📂 From your vault:\n"+searchReply;
                            else actionResult="\n\n📂 Found in vault:\n"+resultText;
                        }else{
                            actionResult="\n\n📂 No matches found for '"+action.query+"' in your vault.";
                        }
                    }else if(action.type==="mark_done"){
                        const ev=allEvents.find(e=>e.id===action.event_id);
                        if(ev){
                            toggleDone(ev);
                            renderHeaderStats();renderSummaryBar();renderListView();
                            actionResult="\n\n✅ Marked done: "+((ev.summary||"").replace(/^Assignment:\s*/i,"").trim());
                        }else{
                            actionResult="\n\n⚠️ Assignment not found. Try asking which assignments are available.";
                        }
                    }else if(action.type==="set_priority"){
                        const ev=allEvents.find(e=>e.id===action.event_id);
                        if(ev){
                            setPrio(ev,action.priority||"HIGH");
                            renderSummaryBar();renderListView();
                            actionResult="\n\n✅ Priority set to "+action.priority+": "+((ev.summary||"").replace(/^Assignment:\s*/i,"").trim());
                        }else{
                            actionResult="\n\n⚠️ Assignment not found.";
                        }
                    }
                }catch(err){
                    actionResult="\n\n⚠️ Action failed: "+err.message;
                }
            }

            typing.remove();
            const fullReply=reply+(actionResult||"");
            chatHistory.push({role:"assistant",content:fullReply,provider:provider});
            renderMessage("assistant",fullReply,provider);
            providerBadge.innerText=provider;
            setTimeout(()=>{msgArea.scrollTop=msgArea.scrollHeight;},50);
        }catch(e){
            typing.remove();
            const raw=(e?.message||"error").toString();
            const cd=parseAIWaitError(raw,"AI_COOLDOWN");
            const gap=parseAIWaitError(raw,"AI_GAP");
            const msg=cd>0?"Rate limited. Wait "+fmtAIWait(cd)+".":gap>0?"Wait "+fmtAIWait(gap)+" before next message.":raw.replace(/^AI_ALL_PROVIDERS_FAILED:/,"").slice(0,120);
            renderMessage("assistant","Error: "+msg,"");
        }finally{
            sendBtn.innerText="Send ⏎";
            sendBtn.style.pointerEvents="";
            chatInput.disabled=false;
            chatInput.focus();
        }
    };

    sendBtn.onclick=sendFollowUp;
    chatInput.onkeydown=e=>{if(e.key==="Enter")sendFollowUp();};
}

async function runAskAIFromHeader(question,inputEl,btnEl){
    const q=(question||"").trim();
    if(!q)return;
    if(!getAIProviders().length){
        openAskAIAnswerModal(q,"API 키를 하나만 등록하면 됩니다. 설정 → AI API Keys에서 Gemini 또는 Groq 키를 등록하세요 (무료).","None");
        return;
    }
    btnEl.style.opacity="0.65";
    btnEl.style.pointerEvents="none";
    const prev=inputEl.placeholder;
    inputEl.placeholder="Thinking...";
    try{
        // Build context from real assignment data
        const now=new Date();
        const tS=new Date(now);tS.setHours(0,0,0,0);
        const tE=new Date(tS);tE.setHours(23,59,59,999);
        const wE=new Date(tS.getTime()+7*86400000);
        const pending=allEvents.filter(ev=>!isDone(ev));
        const todayEvs=pending.filter(ev=>{const d=getEventDate(ev);return d&&d>=tS&&d<=tE;});
        const weekEvs=pending.filter(ev=>{const d=getEventDate(ev);return d&&d>tE&&d<=wE;});
        const overdueEvs=pending.filter(ev=>{const d=getEventDate(ev);return d&&d<tS;});
        const highEvs=pending.filter(ev=>getPrio(ev)==="HIGH");
        const fmtEv=ev=>{
            const d=getEventDate(ev);
            const dl=d?getDaysLeft(d):null;
            const status=dl===null?"no date":dl<0?"OVERDUE":dl===0?"TODAY":dl===1?"TOMORROW":dl+"d left";
            return "- "+((ev.summary||"").replace(/^Assignment:\s*/i,"").trim())+" ["+getCalName(ev)+"] ("+status+")";
        };
        let context="TODAY'S DATE: "+now.toDateString()+"\n\n";
        if(overdueEvs.length)context+="OVERDUE ("+overdueEvs.length+"):\n"+overdueEvs.map(fmtEv).join("\n")+"\n\n";
        if(todayEvs.length)context+="DUE TODAY ("+todayEvs.length+"):\n"+todayEvs.map(fmtEv).join("\n")+"\n\n";
        if(weekEvs.length)context+="THIS WEEK ("+weekEvs.length+"):\n"+weekEvs.map(fmtEv).join("\n")+"\n\n";
        if(highEvs.length)context+="HIGH PRIORITY:\n"+highEvs.map(fmtEv).join("\n")+"\n\n";
        if(!pending.length)context+="No pending assignments.\n\n";
                const data=await guardedAIRequest("ask-header",{
            max_tokens:320,
            messages:[
                {role:"system",content:"You are a concise study and productivity assistant for a student. You have access to their real assignment data below. Answer based on this data.\n\n"+context},
                {role:"user",content:q}
            ]
        });
        const answer=data?.choices?.[0]?.message?.content?.trim()||"No response.";
        openAskAIAnswerModal(q,answer,data?._provider||"AI");
        inputEl.value="";
    }catch(e){
        const raw=(e?.message||"request failed").toString();
        const clean=raw.replace(/^AI_ALL_PROVIDERS_FAILED:/,"");
        const cd=parseAIWaitError(raw,"AI_COOLDOWN");
        const gap=parseAIWaitError(raw,"AI_GAP");
        const msg=cd>0?`AI is rate-limited. Retry in ${fmtAIWait(cd)}.`:gap>0?`Please wait ${fmtAIWait(gap)} before sending another question.`:clean.slice(0,240);
        openAskAIAnswerModal(q,`AI unavailable: ${msg}`,"Fallback");
    }finally{
        btnEl.style.opacity="";
        btnEl.style.pointerEvents="";
        inputEl.placeholder=prev;
    }
}

// -- HEADER -----x----
const header=container.createDiv({cls:"zos-header"});
const hero=header.createDiv({cls:"zos-hero-text"});
const heroTitleStyle = isDarkMode 
  ? "font-size:3.5em;font-weight:900;letter-spacing:-2px;margin-bottom:5px;background:linear-gradient(to right,#fff,rgba(255,255,255,0.4));-webkit-background-clip:text;-webkit-text-fill-color:transparent;"
    : "font-size:3.5em;font-weight:900;letter-spacing:-2px;margin-bottom:5px;background:linear-gradient(to right,rgba(15,23,42,0.96),rgba(var(--zos-accent-rgb),0.86));-webkit-background-clip:text;-webkit-text-fill-color:transparent;";
const heroTitleEl=hero.createEl("h1",{text:bannerTitle,attr:{style:heroTitleStyle}});
const heroSubEl=hero.createDiv({attr:{style:"display:none;"}});


// -- MOTIVATIONAL QUOTE --------------
const quoteEl=hero.createDiv({attr:{style:`opacity:1;font-size:1.1em;letter-spacing:0.5px;font-style:italic;max-width:700px;color:${isDarkMode?"rgba(148,163,184,0.72)":"rgba(30,41,59,0.82)"};`}});
quoteEl.innerText="Loading today's quote...";

async function refreshQuote(force){
    const today=new Date().toDateString();
    const cacheKey="zos-daily-quote";
    const cacheDate="zos-daily-quote-date";
    const fallbackQuotes=[
        "The expert in anything was once a beginner. - Helen Hayes",
        "Learning never exhausts the mind. - Leonardo da Vinci",
        "Discipline is the bridge between goals and accomplishment. - Jim Rohn",
        "Knowledge compounds faster than motivation fades. - Unknown",
        "In cybersecurity, curiosity is your best firewall. - Unknown"
    ];
    const setFallbackQuote=(reason)=>{
        const idxKey="zos-fallback-quote-idx";
        const daySeed=Math.floor(new Date(today).getTime()/86400000);
        let idx=Math.abs(daySeed)%fallbackQuotes.length;
        if(force){
            const prev=parseInt(localStorage.getItem(idxKey)||"-1",10);
            idx=(Number.isNaN(prev)?idx:prev+1)%fallbackQuotes.length;
        }
        localStorage.setItem(idxKey,String(idx));
        const quote=`"${fallbackQuotes[idx]}"`;
        quoteEl.innerText=quote;
        localStorage.setItem(cacheKey,quote);
        localStorage.setItem(cacheDate,today);
        if(reason)console.warn("Quote fallback used:",reason);
    };
    if(force){
        localStorage.removeItem(cacheKey);
        localStorage.removeItem(cacheDate);
        localStorage.removeItem("zos-quote-ai-next-at");
        quoteEl.innerText="Refreshing quote...";
    }
    const cached=localStorage.getItem(cacheKey);
    const cachedDate=localStorage.getItem(cacheDate);
    if(cached&&cachedDate===today){quoteEl.innerText=cached;return;}
    const quoteProviders=getAIProviders();
    const nonGemini=quoteProviders.filter(p=>!String(p.id||"").toLowerCase().startsWith("gemini"));
    if(quoteProviders.length && !nonGemini.length){
        // Keep Gemini quota for assignment summaries instead of daily quote generation.
        setFallbackQuote("Gemini quota preserved for summaries");
        return;
    }
    try{
        const data=await guardedAIRequest("quote",{
                max_tokens:60,
                messages:[{role:"user",content:"Give me one short motivational quote about studying, learning, cybersecurity, or knowledge. Just the quote and author, nothing else. No quote marks around it. Max 20 words."}]
        });
        const quote=data.choices?.[0]?.message?.content?.trim();
        if(quote){
            quoteEl.innerText=`"${quote}"`;
            localStorage.setItem(cacheKey,`"${quote}"`);
            localStorage.setItem(cacheDate,today);
            localStorage.setItem("zos-quote-ai-next-at",String(Date.now()+30*60*1000));
        }else{setFallbackQuote("empty response");}
    }catch(e){
        const raw=(e?.message||"request failed").toString();
        const cd=parseAIWaitError(raw,"AI_COOLDOWN");
        const gap=parseAIWaitError(raw,"AI_GAP");
        if(cd>0){setFallbackQuote(`global cooldown ${fmtAIWait(cd)}`);}
        else if(gap>0){setFallbackQuote(`request gap ${fmtAIWait(gap)}`);}
        else{
            if(raw.includes("429"))localStorage.setItem("zos-quote-ai-next-at",String(Date.now()+60*60*1000));
            setFallbackQuote(raw.slice(0,60));
        }
        console.error("Quote fetch failed:",e);
    }
}

refreshQuote(false);
lastSyncEl=hero.createDiv({attr:{style:`font-size:0.65em;opacity:1;margin-top:6px;font-family:var(--zos-font-mono);color:${isDarkMode?"rgba(100,116,139,0.62)":"rgba(51,65,85,0.72)"};`}});

const bsBtn=header.createDiv({cls:"zos-banner-settings-btn"});
try{setIcon(bsBtn,"settings");}catch(e){bsBtn.innerText="";}
bsBtn.onclick=()=>modal({title:"Dashboard Settings",type:"grid",options:[
    {label:"✎  Edit Title",value:"title"},
    {label:"🎨  Change Accent",value:"accent"},
    {label:"↻  Refresh quote",value:"quote"}
],onSave:async c=>{
    if(c==="title")modal({title:"Dashboard Title",value:bannerTitle,placeholder:"E.g.: MY DASHBOARD",onSave:v=>{if(v.trim()){bannerTitle=v.trim().toUpperCase();save("zos-banner-title",bannerTitle);heroTitleEl.innerText=bannerTitle;}}});
    else if(c==="accent"){
        const ov=document.body.createDiv({cls:"zos-modal-overlay"});
        const mo=ov.createDiv({cls:"zos-modal",attr:{style:`width:400px;background:${modalBg};${modalBlur}color:${modalText};border-color:${modalBorder};box-shadow:${modalShadow};`}});
        ov.onclick=e=>{if(e.target===ov)ov.remove();};
        mo.createDiv({cls:"zos-modal-title",text:"CHOOSE ACCENT"});
        const grid=mo.createDiv({attr:{style:"display:grid;grid-template-columns:repeat(4,1fr);gap:10px;margin-bottom:20px;"}});
        ACCENTS.forEach(p=>{
            const isSel=p.hex===(localStorage.getItem("zos-accent-hex")||"#6366f1");
            const b=grid.createEl("button",{attr:{style:`display:flex;flex-direction:column;align-items:center;gap:8px;padding:12px 5px;border-radius:12px;cursor:pointer;background:${isSel?"rgba(var(--zos-accent-rgb),0.12)":"rgba(255,255,255,0.03)"};border:2px solid ${isSel?p.hex:"rgba(255,255,255,0.08)"};transition:all 0.2s;`}});
            const sw=b.createDiv({attr:{style:`width:24px;height:24px;border-radius:50%;background:${p.hex};box-shadow:${isSel?`0 0 12px ${p.hex}88`:"none"};`}});
            b.createDiv({attr:{style:"font-size:0.6em;font-weight:700;opacity:0.7;"}}).innerText=p.label;
            b.onclick=async()=>{
                save("zos-accent-rgb",p.rgb);save("zos-accent-hex",p.hex);
                document.documentElement.style.setProperty("--zos-accent",p.hex);
                document.documentElement.style.setProperty("--zos-accent-rgb",p.rgb);
                const s=document.getElementById("zos-accent-persist")||document.createElement("style");
                s.id="zos-accent-persist";s.textContent=`:root { --zos-accent: ${p.hex}; --zos-accent-rgb: ${p.rgb}; }`;
                document.head.appendChild(s);
                try{ await saveAccentSnippet(p.rgb,p.hex); }catch(e){}
                ov.remove();
            };
        });
        mo.createEl("button",{cls:"zos-modal-btn zos-btn-cancel",text:"Close",attr:{style:"width:100%;"}}).onclick=()=>ov.remove();
    }
    else if(c==="quote")refreshQuote(true);
}});

const syncBtn=header.createDiv({attr:{style:"position:absolute;top:16px;right:44px;cursor:pointer;opacity:0.4;transition:all 0.3s ease;display:flex;align-items:center;justify-content:center;color:var(--text-normal);z-index:10;"}});
try{setIcon(syncBtn,"refresh-cw");}catch(e){syncBtn.innerText="↺";}
syncBtn.onmouseenter=()=>{syncBtn.style.opacity="1";syncBtn.style.color="var(--zos-accent)";};
syncBtn.onmouseleave=()=>{syncBtn.style.opacity="0.4";syncBtn.style.color="";};
syncBtn.onclick=()=>{fetchAndRender();fetchAINews();fetchGitHub();refreshQuote(true);};

header.style.overflow = "visible";

const statsCont=header.createDiv({cls:"zos-hero-stats",attr:{style:`
    display:flex;
    flex-wrap:wrap;
    gap:12px;
    justify-content:flex-end;
    align-items:stretch;
    max-width:min(100%, 420px);
    margin-left:auto;
    overflow:visible;
`}});
function renderHeaderStats(){
    statsCont.innerHTML="";
    const pending=allEvents.filter(ev=>!isDone(ev)).length;
    [{v:dv.pages().length,l:"Notes",i:"files"},{v:pending,l:"Pending",i:"clock"}].forEach(s=>{
        const cube=statsCont.createDiv({cls:"zos-stat-cube",attr:{style:`
            min-width:160px;
            flex:1 1 160px;
            max-width:200px;
            box-sizing:border-box;
            overflow:visible;
        `}});
        const tr=cube.createDiv({attr:{style:"display:flex;align-items:center;justify-content:flex-end;gap:10px;min-width:0;"}});
        const ic=tr.createDiv({attr:{style:`display:flex;align-items:center;justify-content:center;min-width:20px;color:${isDarkMode?"rgba(226,232,240,0.9)":"rgba(67,56,202,0.92)"};`}});try{setIcon(ic,s.i);}catch(e){ic.innerText="";}
        tr.createDiv({cls:"zos-stat-val",text:s.v.toString()});
        cube.createDiv({cls:"zos-stat-lab",text:s.l});
    });
}
renderHeaderStats();

// -- LAYOUT ------------------------------
const grid=container.createDiv({cls:"zos-grid",attr:{style:"margin-top:0;align-items:start;"}});
const leftCol=grid.createDiv({cls:"zos-col-grid zos-left-col",attr:{style:"grid-column:span 4;background:transparent;"}});
const rightCol=grid.createDiv({cls:"zos-col-grid zos-right-col",attr:{style:"grid-column:span 8;background:transparent;"}});

function makeCard(id){
    const w=document.createElement("div");
    w.setAttribute("data-card-id",id);
    w.className="zos-card-shell zos-left-card";
    applyCardSpan(w,id);
    return w;
}

function makeRightCard(id){
    const w=document.createElement("div");
    w.setAttribute("data-right-id",id);
    w.className="zos-card-shell zos-right-card";
    applyCardSpan(w,id);
    return w;
}

// -- CLOCK CARD ----------------
function buildClockCard(){
    const w=makeCard("clock");
    const cClock=w.createDiv({cls:"zos-card zos-clock-card",attr:{style:isDarkMode?"":"background:#ffffff;color:#0f0f0f;border-color:rgba(0,0,0,0.09);"}});
    const clockTimeEl=cClock.createDiv({attr:{style:"font-family:var(--zos-font-mono);font-size:3.2em;font-weight:700;letter-spacing:-4px;line-height:1;margin-bottom:4px;color:var(--zos-accent);text-shadow:0 0 30px rgba(var(--zos-accent-rgb),0.4);white-space:nowrap;cursor:grab;user-select:none;"}});
    clockTimeEl.setAttribute("data-drag-handle","true");
    const clockDateEl=cClock.createDiv({attr:{style:"font-size:0.8em;font-weight:600;opacity:0.5;letter-spacing:1px;margin-bottom:20px;"}});
    const mkBar=(label,color,last)=>{
        const row=cClock.createDiv({attr:{style:"display:flex;justify-content:space-between;align-items:center;margin-bottom:6px;"}});
        row.createDiv({text:label,attr:{style:"font-size:0.6em;font-weight:700;letter-spacing:2px;opacity:0.4;"}});
        const pct=row.createDiv({attr:{style:`font-size:0.65em;font-weight:700;color:${color};font-family:var(--zos-font-mono);`}});
        const bg=cClock.createDiv({attr:{style:`height:5px;background:${isDarkMode?"rgba(255,255,255,0.05)":"rgba(148,163,184,0.22)"};border-radius:3px;overflow:hidden;${last?"":"margin-bottom:18px;"}`}});
        const bar=bg.createDiv({attr:{style:`height:100%;background:${color};border-radius:3px;transition:width 1s linear;width:0%;`}});
        return {pct,bar};
    };
    const day=mkBar("DAY PROGRESS","var(--zos-accent)",false);
    const week=mkBar("WEEK PROGRESS","#ffc800",false);
    const yr=mkBar("YEAR PROGRESS","#ff8c00",true);
    function updateClock(){
        const now=new Date();
        const tp=now.toLocaleTimeString("en-US",{hour:"2-digit",minute:"2-digit",second:"2-digit",hour12:true});
        clockTimeEl.innerText=tp.replace(/\s?(AM|PM)/," $1");
        clockDateEl.innerText=now.toLocaleDateString("en-US",{weekday:"long",month:"long",day:"numeric",year:"numeric"}).toUpperCase();
        const ss=now.getHours()*3600+now.getMinutes()*60+now.getSeconds();
        const dp=((ss/86400)*100).toFixed(1);day.bar.style.width=`${dp}%`;day.pct.innerText=`${dp}%`;
        const dow=(now.getDay()+6)%7;
        const wp=(((dow*86400+ss)/(7*86400))*100).toFixed(1);week.bar.style.width=`${wp}%`;week.pct.innerText=`${wp}%`;
        const soy=new Date(now.getFullYear(),0,1),eoy=new Date(now.getFullYear()+1,0,1);
        const yp=(((now-soy)/(eoy-soy))*100).toFixed(1);yr.bar.style.width=`${yp}%`;yr.pct.innerText=`${yp}%`;
    }
    if(clockInterval)clearInterval(clockInterval);
    updateClock();clockInterval=setInterval(updateClock,1000);
    return w;
}

// -- OBJECTIVE CARD ----------------
function buildObjectiveCard(){
    const w=makeCard("objective");
    const cFocus=w.createDiv({cls:"zos-card",attr:{style:isDarkMode?"":"background:#ffffff;color:#0f0f0f;border-color:rgba(0,0,0,0.09);"}});
    const titleEl=cFocus.createDiv({cls:"zos-card-title",text:"OBJECTIVE",attr:{style:"cursor:grab;user-select:none;"}});
    titleEl.setAttribute("data-drag-handle","true");
    const focusVal=cFocus.createDiv({text:localStorage.getItem("zos-focus")||"Define your success today...",attr:{contenteditable:true,style:"font-family:var(--zos-font-ser);font-size:2em;outline:none;line-height:1.15;cursor:text;"}});
    focusVal.onblur=()=>save("zos-focus",focusVal.innerText);
    return w;
}

// -- SYSTEM CARD -----------------
function buildSystemCard(){
    const w=makeCard("system");
    const cAct=w.createDiv({cls:"zos-card",attr:{style:isDarkMode?"":"background:#ffffff;color:#0f0f0f;border-color:rgba(0,0,0,0.09);"}});
    const titleEl=cAct.createDiv({cls:"zos-card-title",text:"SYSTEM",attr:{style:"cursor:grab;user-select:none;"}});
    titleEl.setAttribute("data-drag-handle","true");
    const aGrid=cAct.createDiv({attr:{style:"display:grid;grid-template-columns:1fr 1fr;gap:12px;"}});

    const pomBar=cAct.createDiv({attr:{style:`display:none;margin-top:16px;padding:14px;background:${isDarkMode?"rgba(255,255,255,0.03)":"rgba(241,245,249,0.82)"};border-radius:14px;border:1px solid ${isDarkMode?"rgba(255,255,255,0.06)":"rgba(148,163,184,0.16)"};`}});
    const pomTop=pomBar.createDiv({attr:{style:"display:flex;align-items:center;justify-content:space-between;margin-bottom:10px;"}});
    const pomLabel=pomTop.createDiv({attr:{style:"font-size:0.65em;font-weight:700;letter-spacing:1.5px;opacity:0.4;"}});
    pomLabel.innerText="FOCUS SESSION";
    const pomClose=pomTop.createDiv({attr:{style:"font-size:0.75em;opacity:0.3;cursor:pointer;padding:2px 6px;border-radius:6px;transition:all 0.2s;"}});
    pomClose.innerText="✕";
    pomClose.onmouseenter=()=>{pomClose.style.opacity="1";pomClose.style.background="rgba(255,85,85,0.15)";pomClose.style.color="#ff5555";};
    pomClose.onmouseleave=()=>{pomClose.style.opacity="0.3";pomClose.style.background="";pomClose.style.color="";};
    const pomDisplay=pomBar.createDiv({attr:{style:"font-family:var(--zos-font-mono);font-size:2.4em;font-weight:700;color:var(--zos-accent);letter-spacing:-1px;text-align:center;margin-bottom:10px;"}});
    pomDisplay.innerText="25:00";
    const pomPhaseRow=pomBar.createDiv({attr:{style:"display:flex;gap:5px;margin-bottom:10px;"}});
    const pomPhases=[{l:"Focus",s:25*60},{l:"Short",s:5*60},{l:"Long",s:15*60}];
    let pomPhaseIdx=0,pomSecs=25*60,pomTimer=null,pomRunning=false;
    const pomBtnRow=pomBar.createDiv({attr:{style:"display:flex;gap:6px;"}});
    const pomStart=pomBtnRow.createEl("button",{attr:{style:"flex:1;font-size:0.75em;font-weight:700;padding:8px;border-radius:10px;background:rgba(var(--zos-accent-rgb),0.12);color:var(--zos-accent);border:1px solid rgba(var(--zos-accent-rgb),0.25);cursor:pointer;transition:all 0.2s;"}});
    pomStart.innerText="▶ Start";
    const pomReset=pomBtnRow.createEl("button",{attr:{style:`font-size:0.75em;font-weight:700;padding:8px 12px;border-radius:10px;background:${isDarkMode?"rgba(255,255,255,0.04)":"rgba(226,232,240,0.92)"};color:${isDarkMode?"rgba(255,255,255,0.4)":"rgba(51,65,85,0.72)"};border:1px solid ${isDarkMode?"rgba(255,255,255,0.08)":"rgba(148,163,184,0.2)"};cursor:pointer;`}});
    pomReset.innerText="↺";
    const pomUpdateDisplay=()=>{
        const m=Math.floor(pomSecs/60),s=pomSecs%60;
        pomDisplay.innerText=`${String(m).padStart(2,"0")}:${String(s).padStart(2,"0")}`;
        pomDisplay.style.color=pomSecs<=60?"#ff5555":pomSecs<=5*60?"#ff8c00":"var(--zos-accent)";
    };
    const pomSetPhase=(i)=>{
        pomPhaseIdx=i;pomSecs=pomPhases[i].s;
        pomLabel.innerText=pomPhases[i].l.toUpperCase()+" SESSION";
        clearInterval(pomTimer);pomRunning=false;pomStart.innerText="▶ Start";
        pomUpdateDisplay();
        pomPhaseRow.querySelectorAll("button").forEach((b,j)=>{
            b.style.background=j===i?"rgba(var(--zos-accent-rgb),0.15)":(isDarkMode?"rgba(255,255,255,0.04)":"rgba(226,232,240,0.92)");
            b.style.color=j===i?"var(--zos-accent)":(isDarkMode?"rgba(255,255,255,0.4)":"rgba(51,65,85,0.72)");
        });
    };
    pomPhases.forEach((p,i)=>{
        const tb=pomPhaseRow.createEl("button",{attr:{style:`flex:1;font-size:0.62em;font-weight:700;padding:4px 6px;border-radius:8px;cursor:pointer;transition:all 0.2s;border:1px solid ${isDarkMode?"rgba(255,255,255,0.06)":"rgba(148,163,184,0.16)"};background:${i===0?"rgba(var(--zos-accent-rgb),0.15)":(isDarkMode?"rgba(255,255,255,0.04)":"rgba(226,232,240,0.92)")};color:${i===0?"var(--zos-accent)":(isDarkMode?"rgba(255,255,255,0.4)":"rgba(51,65,85,0.72)")};`}});
        tb.innerText=p.l;tb.onclick=()=>pomSetPhase(i);
    });
    pomStart.onclick=()=>{
        if(pomRunning){clearInterval(pomTimer);pomRunning=false;pomStart.innerText="▶ Start";}
        else{
            pomRunning=true;pomStart.innerText="⏸ Pause";
            pomTimer=setInterval(()=>{
                pomSecs--;pomUpdateDisplay();
                if(pomSecs<=0){clearInterval(pomTimer);pomRunning=false;pomStart.innerText="▶ Start";new Notice(pomPhaseIdx===0?"Focus done! Take a break.":"Break over! Back to focus.");}
            },1000);
        }
    };
    pomReset.onclick=()=>{clearInterval(pomTimer);pomRunning=false;pomStart.innerText="▶ Start";pomSecs=pomPhases[pomPhaseIdx].s;pomUpdateDisplay();};
    pomClose.onclick=()=>{clearInterval(pomTimer);pomRunning=false;pomSecs=pomPhases[pomPhaseIdx].s;pomUpdateDisplay();pomBar.style.display="none";};

    [{n:"Search",icon:"search",em:"search",cmd:"__search__"},{n:"Stats",icon:"bar-chart-2",em:"bar-chart-2",cmd:"__stats__"},{n:"Pomodoro",icon:"timer",em:"timer",cmd:"__pomodoro__"},{n:"New Note",icon:"plus-circle",em:"plus-circle",cmd:"__newnote__"}].forEach(op=>{
        const btn=aGrid.createDiv({cls:"zos-action-btn"}),ic=btn.createDiv();
        try{setIcon(ic,op.icon);}catch(e){ic.innerText=op.em;}
        btn.createDiv({text:op.n.toUpperCase(),attr:{style:"font-size:0.68em;font-weight:700;margin-top:5px;"}});
        if(op.cmd==="__search__"){
            btn.onclick=()=>{
                const ov=document.body.createDiv({cls:"zos-modal-overlay"});
                const mo=ov.createDiv({cls:"zos-modal",attr:{style:`width:520px;max-height:85vh;display:flex;flex-direction:column;background:${modalBg};${modalBlur}color:${modalText};border-color:${modalBorder};box-shadow:${modalShadow};`}});
                ov.onclick=e=>{if(e.target===ov)ov.remove();};
                mo.createDiv({cls:"zos-modal-title",attr:{style:`color:${modalText};`},text:"SEARCH VAULT"});
                const sub=mo.createDiv({attr:{style:`font-size:0.72em;color:${isDarkMode?'rgba(255,255,255,0.5)':'rgba(0,0,0,0.5)'};margin-bottom:12px;`}});
                sub.innerText="Search in file names and content (e.g. roll no, keyword)";
                const row=mo.createDiv({attr:{style:"display:flex;gap:8px;margin-bottom:14px;"}});
                const inp=row.createEl("input",{cls:"zos-modal-input",attr:{type:"text",placeholder:"e.g. hello world or keyword...",style:"flex:1;margin:0;"}});
                inp.focus();
                const searchBtn=row.createEl("button",{cls:"zos-modal-btn zos-btn-save",text:"Search",attr:{style:"margin:0;white-space:nowrap;"}});
                const resultsEl=mo.createDiv({attr:{style:`flex:1;overflow-y:auto;max-height:360px;min-height:120px;border:1px solid ${isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.08)"};border-radius:10px;padding:10px;background:${isDarkMode ? "rgba(0,0,0,0.2)" : "rgba(255,255,255,0.9)"};`}});
                resultsEl.createDiv({attr:{style:"text-align:center;padding:24px;opacity:0.4;font-size:0.85em;"}}).innerText="Type to search (results update as you type)";
                let searchId=0, debounceTimer=null;
                const runSearch=async()=>{
                    const q=(inp.value||"").trim();
                    const myId=++searchId;
                    if(!q){resultsEl.innerHTML="";resultsEl.createDiv({attr:{style:"text-align:center;padding:24px;opacity:0.4;font-size:0.85em;"}}).innerText="Type to search (results update as you type)";return;}
                    resultsEl.innerHTML="";
                    resultsEl.createDiv({attr:{style:"text-align:center;padding:24px;opacity:0.6;font-size:0.85em;"}}).innerText="Searching...";
                    const files=app.vault.getMarkdownFiles();
                    const hits=[];
                    for(const file of files){
                        if(myId!==searchId)return;
                        const nameMatch=file.path.toLowerCase().includes(q.toLowerCase())||file.basename.toLowerCase().includes(q.toLowerCase());
                        let content="";
                        try{content=await app.vault.cachedRead(file);}catch(e){}
                        const contentMatch=content&&content.toLowerCase().includes(q.toLowerCase());
                        if(nameMatch||contentMatch){
                            const lines=content?content.split(/\r?\n/):[];
                            const snippetLines=contentMatch?lines.filter(l=>l.toLowerCase().includes(q.toLowerCase())).slice(0,2):[];
                            const snippet=snippetLines.length?snippetLines.map(l=>l.trim().slice(0,120)+(l.trim().length>120?"…":"")).join(" · "):(nameMatch?"(filename match)":"");
                            hits.push({file,path:file.path,snippet,contentMatch,nameMatch});
                        }
                    }
                    if(myId!==searchId)return;
                    resultsEl.innerHTML="";
                    if(!hits.length){resultsEl.createDiv({attr:{style:"text-align:center;padding:24px;opacity:0.5;font-size:0.85em;"}}).innerText="No results for \""+q+"\"";return;}
                    const idxToPos=(content,idx)=>{
                        let pos=0;
                        const lines=content.split(/\r?\n/);
                        for(let i=0;i<lines.length;i++){const lineEnd=pos+lines[i].length;if(idx<=lineEnd)return{line:i,ch:idx-pos};pos=lineEnd+1;}
                        return{line:Math.max(0,lines.length-1),ch:lines[lines.length-1]?.length||0};
                    };
                    hits.forEach(({file,path,snippet})=>{
                        const item=resultsEl.createDiv({attr:{style:`padding:10px 12px;margin-bottom:6px;background:${isDarkMode ? "rgba(255,255,255,0.04)" : "rgba(0,0,0,0.03)"};border-radius:8px;border:1px solid ${isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.08)"};cursor:pointer;transition:background 0.15s,border-color 0.15s;`}});
                        item.createDiv({attr:{style:"font-size:0.8em;font-weight:600;color:var(--zos-accent);margin-bottom:4px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"}}).innerText=path;
                        if(snippet)item.createDiv({attr:{style:"font-size:0.75em;opacity:0.7;line-height:1.35;overflow:hidden;text-overflow:ellipsis;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;"}}).innerText=snippet;
                        item.onclick=async()=>{
                            const leaf=app.workspace.getLeaf();
                            await leaf.openFile(file);
                            ov.remove();
                            const view=leaf.view;
                            if(view&&view.editor){
                                const editor=view.editor;
                                const content=editor.getValue();
                                const idx=content.toLowerCase().indexOf(q.toLowerCase());
                                if(idx!==-1){
                                    const from=idxToPos(content,idx);
                                    const to=idxToPos(content,idx+q.length);
                                    editor.setSelection(from,to);
                                    editor.scrollIntoView({from,to},true);
                                }
                            }
                        };
                        item.onmouseenter=()=>{item.style.background="rgba(var(--zos-accent-rgb),0.08)";item.style.borderColor="rgba(var(--zos-accent-rgb),0.25)";};
                        item.onmouseleave=()=>{item.style.background=isDarkMode ? "rgba(255,255,255,0.04)" : "rgba(0,0,0,0.03)";item.style.borderColor=isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.08)";};
                    });
                };
                searchBtn.onclick=runSearch;
                inp.oninput=()=>{clearTimeout(debounceTimer);debounceTimer=setTimeout(runSearch,280);};
                inp.onkeydown=e=>{if(e.key==="Enter"){clearTimeout(debounceTimer);runSearch();}if(e.key==="Escape")ov.remove();};
                mo.createEl("button",{cls:"zos-modal-btn zos-btn-cancel",text:"Close",attr:{style:"width:100%;margin-top:10px;"}}).onclick=()=>ov.remove();
            };
        }else if(op.cmd==="__stats__"){
            btn.onclick=()=>{
                const files=app.vault.getFiles(),notes=files.filter(f=>f.extension==="md");
                const folders=new Set(notes.map(f=>f.parent?.path)).size;
                const byFolder={};notes.forEach(f=>{const p=f.parent?.name||"Root";byFolder[p]=(byFolder[p]||0)+1;});
                const top=Object.entries(byFolder).sort((a,b)=>b[1]-a[1]).slice(0,5);
                const ov=document.body.createDiv({cls:"zos-modal-overlay"});
                const mo=ov.createDiv({cls:"zos-modal",attr:{style:`background:${modalBg};${modalBlur}color:${modalText};border-color:${modalBorder};box-shadow:${modalShadow};`}});
                ov.onclick=e=>{if(e.target===ov)ov.remove();};
                mo.createDiv({cls:"zos-modal-title",attr:{style:`color:${modalText};`},text:"VAULT STATS"});
                [{l:"Total Notes",v:notes.length},{l:"Total Files",v:files.length},{l:"Folders",v:folders}].forEach(s=>{
                    const row=mo.createDiv({attr:{style:`display:flex;justify-content:space-between;align-items:center;padding:10px 0;border-bottom:1px solid ${isDarkMode ? "rgba(255,255,255,0.05)" : "rgba(0,0,0,0.08)"};`}});
                    row.createDiv({attr:{style:"font-size:0.82em;opacity:0.5;"}}).innerText=s.l;
                    row.createDiv({attr:{style:"font-size:1em;font-weight:700;color:var(--zos-accent);"}}).innerText=s.v;
                });
                mo.createDiv({attr:{style:"font-size:0.7em;font-weight:700;letter-spacing:1px;opacity:0.4;margin:14px 0 8px;"}}).innerText="TOP FOLDERS";
                top.forEach(([name,count])=>{
                    const row=mo.createDiv({attr:{style:"display:flex;justify-content:space-between;align-items:center;padding:7px 0;"}});
                    row.createDiv({attr:{style:"font-size:0.8em;opacity:0.6;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;max-width:70%;"}}).innerText=name;
                    row.createDiv({attr:{style:"font-size:0.78em;font-weight:700;padding:2px 8px;border-radius:8px;background:rgba(var(--zos-accent-rgb),0.1);color:var(--zos-accent);"}}).innerText=count+" notes";
                });
                mo.createEl("button",{cls:"zos-modal-btn zos-btn-cancel",text:"Close",attr:{style:"width:100%;margin-top:16px;"}}).onclick=()=>ov.remove();
            };
        }else if(op.cmd==="__pomodoro__"){
            btn.onclick=()=>{pomBar.style.display=pomBar.style.display==="none"?"block":"none";};
        }else if(op.cmd==="__newnote__"){
            btn.onclick=async()=>{
                const ROOT="/";let currentPath=ROOT;
                const ov=document.body.createDiv({cls:"zos-modal-overlay"});
                const mo=ov.createDiv({cls:"zos-modal",attr:{style:`width:480px;max-height:80vh;display:flex;flex-direction:column;background:${modalBg};${modalBlur}color:${modalText};border-color:${modalBorder};box-shadow:${modalShadow};`}});
                ov.onclick=e=>{if(e.target===ov)ov.remove();};
                mo.createDiv({cls:"zos-modal-title",attr:{style:`color:${modalText};`},text:"NEW NOTE"});
                const nameRow=mo.createDiv({attr:{style:"margin-bottom:16px;"}});
                nameRow.createDiv({attr:{style:"font-size:0.7em;font-weight:700;letter-spacing:1px;opacity:0.4;margin-bottom:6px;"}}).innerText="NOTE NAME";
                const nameInp=nameRow.createEl("input",{cls:"zos-modal-input",attr:{type:"text",placeholder:"Enter note name...",style:"margin-bottom:0;"}});
                nameInp.focus();
                const breadcrumbEl=mo.createDiv({attr:{style:`display:flex;align-items:center;gap:4px;flex-wrap:wrap;padding:8px 12px;background:${isDarkMode ? "rgba(255,255,255,0.03)" : "rgba(0,0,0,0.03)"};border-radius:10px;margin-bottom:10px;border:1px solid ${isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.08)"};min-height:34px;`}});
                const folderList=mo.createDiv({attr:{style:"flex:1;overflow-y:auto;max-height:280px;display:flex;flex-direction:column;gap:4px;padding-right:2px;margin-bottom:14px;"}});
                const newFolderRow=mo.createDiv({attr:{style:"display:flex;gap:8px;margin-bottom:14px;"}});
                const newFolderInp=newFolderRow.createEl("input",{attr:{type:"text",placeholder:"New folder name...",style:`flex:1;background:${isDarkMode ? "rgba(255,255,255,0.04)" : "rgba(0,0,0,0.03)"};border:1px solid ${isDarkMode ? "rgba(255,255,255,0.08)" : "rgba(0,0,0,0.12)"};border-radius:10px;padding:8px 12px;color:${isDarkMode ? "#fff" : "#1f2937"};font-size:0.8em;outline:none;`}});
                const newFolderBtn=newFolderRow.createEl("button",{attr:{style:"padding:8px 14px;border-radius:10px;background:rgba(var(--zos-accent-rgb),0.12);color:var(--zos-accent);border:1px solid rgba(var(--zos-accent-rgb),0.25);font-size:0.75em;font-weight:700;cursor:pointer;white-space:nowrap;"}});
                newFolderBtn.innerText="+ Create";
                newFolderInp.onfocus=()=>{newFolderInp.style.borderColor="var(--zos-accent)";};
                newFolderInp.onblur=()=>{newFolderInp.style.borderColor=isDarkMode ? "rgba(255,255,255,0.08)" : "rgba(0,0,0,0.12)";};
                const actionRow=mo.createDiv({attr:{style:"display:flex;gap:8px;"}});
                const cancelBtn=actionRow.createEl("button",{cls:"zos-modal-btn zos-btn-cancel",text:"Cancel",attr:{style:"flex:1;"}});
                const saveBtn=actionRow.createEl("button",{cls:"zos-modal-btn zos-btn-save",attr:{style:"flex:1;"}});
                saveBtn.innerText="Save Here";cancelBtn.onclick=()=>ov.remove();

                const renderBreadcrumb=()=>{
                    breadcrumbEl.innerHTML="";
                    if(currentPath==="/"){breadcrumbEl.createDiv({attr:{style:"font-size:0.72em;font-weight:700;color:var(--zos-accent);"}}).innerText="Vault Root";return;}
                    const parts=currentPath.split("/");
                    const rc=breadcrumbEl.createDiv({attr:{style:`font-size:0.72em;font-weight:500;color:${isDarkMode ? "rgba(255,255,255,0.4)" : "rgba(0,0,0,0.5)"};cursor:pointer;transition:color 0.15s;`}});
                    rc.innerText="Root";rc.onclick=()=>{currentPath="/";renderFolders();};
                    rc.onmouseenter=()=>{rc.style.color=isDarkMode ? "rgba(255,255,255,0.7)" : "rgba(0,0,0,0.75)";};
                    rc.onmouseleave=()=>{rc.style.color=isDarkMode ? "rgba(255,255,255,0.4)" : "rgba(0,0,0,0.5)";};
                    breadcrumbEl.createDiv({attr:{style:"font-size:0.7em;opacity:0.3;"}}).innerText="›";
                    parts.forEach((part,i)=>{
                        const isLast=i===parts.length-1;
                        const crumb=breadcrumbEl.createDiv({attr:{style:`font-size:0.72em;font-weight:${isLast?"700":"500"};color:${isLast?"var(--zos-accent)":(isDarkMode ? "rgba(255,255,255,0.4)" : "rgba(0,0,0,0.5)")};${isLast?"":"cursor:pointer;"}transition:color 0.15s;white-space:nowrap;`}});
                        crumb.innerText=part;
                        if(!isLast){
                            crumb.onclick=()=>{currentPath=parts.slice(0,i+1).join("/");renderFolders();};
                            crumb.onmouseenter=()=>{crumb.style.color=isDarkMode ? "rgba(255,255,255,0.7)" : "rgba(0,0,0,0.75)";};
                            crumb.onmouseleave=()=>{crumb.style.color=isDarkMode ? "rgba(255,255,255,0.4)" : "rgba(0,0,0,0.5)";};
                            breadcrumbEl.createDiv({attr:{style:"font-size:0.7em;opacity:0.3;"}}).innerText="›";
                        }
                    });
                };

                const renderFolders=()=>{
                    folderList.innerHTML="";renderBreadcrumb();
                    const folder=currentPath==="/"?app.vault.getRoot():app.vault.getAbstractFileByPath(currentPath);
                    if(!folder){folderList.createDiv({attr:{style:"text-align:center;padding:20px;opacity:0.3;font-size:0.8em;"}}).innerText="Folder not found";return;}
                    const children=folder.children||[];
                    const subFolders=children.filter(f=>f.children).sort((a,b)=>a.name.localeCompare(b.name));
                    const files=children.filter(f=>!f.children).sort((a,b)=>a.name.localeCompare(b.name));
                    if(currentPath!=="/"){
                        const upBtn=folderList.createDiv({attr:{style:`display:flex;align-items:center;gap:10px;padding:9px 12px;border-radius:10px;cursor:pointer;transition:background 0.15s;color:${isDarkMode ? "rgba(255,255,255,0.4)" : "rgba(0,0,0,0.5)"};font-size:0.82em;`}});
                        upBtn.createDiv({attr:{style:"width:18px;text-align:center;"}}).innerText="↑";
                        upBtn.createDiv({text:".. (go up)"});
                        upBtn.onmouseenter=()=>{upBtn.style.background=isDarkMode ? "rgba(255,255,255,0.04)" : "rgba(0,0,0,0.04)";};
                        upBtn.onmouseleave=()=>{upBtn.style.background="";};
                        upBtn.onclick=()=>{const p=currentPath.split("/");currentPath=p.length<=1?"/":p.slice(0,-1).join("/");renderFolders();};
                    }
                    if(!subFolders.length&&!files.length)folderList.createDiv({attr:{style:"text-align:center;padding:16px;opacity:0.3;font-size:0.78em;"}}).innerText="Empty folder";
                    subFolders.forEach(f=>{
                        const row=folderList.createDiv({attr:{style:"display:flex;align-items:center;gap:10px;padding:9px 12px;border-radius:10px;cursor:pointer;transition:background 0.15s;border:1px solid transparent;"}});
                        const folderIcon=row.createDiv({attr:{style:"width:18px;text-align:center;flex-shrink:0;display:flex;align-items:center;justify-content:center;"}});
                        try{setIcon(folderIcon,"folder");}catch(e){folderIcon.innerText="▶";}
                        row.createDiv({attr:{style:"font-size:0.84em;font-weight:600;flex:1;"}}).innerText=f.name;
                        const sub=f.children?.filter(c=>c.children).length||0;
                        if(sub>0)row.createDiv({attr:{style:"font-size:0.65em;opacity:0.3;"}}).innerText=`${sub} folder${sub>1?"s":""}`;
                        row.createDiv({attr:{style:"font-size:0.75em;opacity:0.3;"}}).innerText="›";
                        row.onmouseenter=()=>{row.style.background=isDarkMode ? "rgba(255,255,255,0.05)" : "rgba(0,0,0,0.04)";row.style.borderColor=isDarkMode ? "rgba(255,255,255,0.07)" : "rgba(0,0,0,0.1)";};
                        row.onmouseleave=()=>{row.style.background="";row.style.borderColor="transparent";};
                        row.onclick=()=>{currentPath=f.path;renderFolders();};
                    });
                    files.forEach(f=>{
                        const row=folderList.createDiv({attr:{style:"display:flex;align-items:center;gap:10px;padding:7px 12px;border-radius:10px;opacity:0.35;"}});
                        row.createDiv({attr:{style:"width:18px;text-align:center;flex-shrink:0;"}}).innerText="D";
                        row.createDiv({attr:{style:"font-size:0.8em;"}}).innerText=f.name;
                    });
                    const fn=currentPath==="/"?"Vault Root":currentPath.split("/").pop();
                    saveBtn.innerText=`Save in "${fn}"`;
                };

                newFolderBtn.onclick=async()=>{
                    const name=newFolderInp.value.trim();if(!name)return;
                    const newPath=currentPath==="/"?name:`${currentPath}/${name}`;
                    try{await app.vault.createFolder(newPath);newFolderInp.value="";currentPath=newPath;renderFolders();}catch(e){new Notice(`Error: ${e.message}`);}
                };
                newFolderInp.onkeydown=e=>{if(e.key==="Enter")newFolderBtn.click();};
                saveBtn.onclick=async()=>{
                    const name=nameInp.value.trim();
                    if(!name){nameInp.style.borderColor="#ff5555";nameInp.focus();return;}
                    const fullPath=currentPath==="/"?`${name}.md`:`${currentPath}/${name}.md`;
                    try{await app.vault.create(fullPath,"");await app.workspace.openLinkText(fullPath,"",false);ov.remove();}catch(e){new Notice(`Error: ${e.message}`);}
                };
                nameInp.onkeydown=e=>{if(e.key==="Enter")saveBtn.click();};
                renderFolders();
            };
        }
    });
    return w;
}

// -- PIPELINE CARD ---------------
let gcalBadge,summaryBar,listCont,monthCont,calGridEl,calTitleEl,sortControlWrap;

function buildPipelineCard(){
    const w=makeRightCard("pipeline");
    w.classList.add("zos-resizable-card");
    attachResizeHandle(w,"pipeline",()=>rightCol);
    const cTasks=w.createDiv({cls:"zos-card",attr:{style:isDarkMode?"":"background:#ffffff;color:#0f0f0f;border-color:rgba(0,0,0,0.09);"}});
    const tHd=cTasks.createDiv({cls:"zos-card-title",attr:{style:"justify-content:space-between;margin-bottom:0;flex-wrap:wrap;gap:10px;cursor:grab;user-select:none;"}});
    tHd.setAttribute("data-right-drag","true");
    const tL=tHd.createDiv({attr:{style:"display:flex;align-items:center;gap:10px;pointer-events:none;"}});
    tL.createDiv({text:"ASSIGNMENT PIPELINE"});
    gcalBadge=tL.createDiv({cls:"zos-task-source-indicator",text:"ALL COURSES"});
    const tR=tHd.createDiv({attr:{style:"display:flex;align-items:center;gap:6px;flex-wrap:wrap;pointer-events:auto;"}});
    sortControlWrap=tR.createDiv({cls:"zos-control-group"});
    sortControlWrap.createDiv({cls:"zos-control-label",text:"Sort by"});
    const sortBtn=sortControlWrap.createDiv({cls:"zos-control-value"});
    const sortLabels={date:"DATE",course:"COURSE"};
    const nextSortMode=()=>sortMode==="date"?"course":"date";
    sortBtn.innerText=sortLabels[nextSortMode()]||"DATE";
    sortBtn.onclick=()=>{sortMode=nextSortMode();save("zos-sort-mode",sortMode);sortBtn.innerText=sortLabels[nextSortMode()];switchView();};
    const viewWrap=tR.createDiv({cls:"zos-control-group"});
    viewWrap.createDiv({cls:"zos-control-label",text:"View as"});
    const viewBtn=viewWrap.createDiv({cls:"zos-control-value zos-control-value-accent"});
    viewBtn.innerText=pipelineView==="list"?"MONTH":"LIST";
    viewBtn.onclick=()=>{pipelineView=pipelineView==="list"?"month":"list";save("zos-pipeline-view",pipelineView);viewBtn.innerText=pipelineView==="list"?"MONTH":"LIST";switchView();};
    const filterBtn=tR.createDiv({cls:"zos-settings-btn"});try{setIcon(filterBtn,"settings");}catch(e){filterBtn.innerText="";}
    filterBtn.onclick=async()=>{
        try{
            const gw=window.googleWorkspace;
            if(!gw) throw new Error("Google Workspace plugin not found.");
            if(!gw.isConnected()) throw new Error("Not connected — open Google Workspace settings.");
            if(!Array.isArray(allCalendars)||allCalendars.length===0){
                const calSources=[];
                if(gw.getCourses){
                    const courses=await gw.getCourses();
                    calSources.push(...(courses||[]).map(c=>({id:c.id,summary:c.name||c.id})));
                }
                if(gw.getCalendars){
                    const cals=await gw.getCalendars();
                    (cals||[]).forEach(c=>{
                        if(!calSources.some(s=>s.id===c.id)) calSources.push({id:c.id,summary:c.name||c.summary||c.id});
                    });
                }
                allCalendars=calSources;
            }
            modal({title:"Filter by Course",type:"multicheck",options:allCalendars.map(c=>({label:c.summary||c.id,value:c.summary||c.id})),selected:selectedCals,onSave:async p=>{selectedCals=p;save("zos-selected-calendars",p);saveCalFilterToVault(p);await fetchAndRender();}});
        }catch(e){new Notice(`Error: ${e.message}`);}
    };
    summaryBar=cTasks.createDiv({attr:{style:"display:flex;gap:5px;margin:14px 0 18px;flex-wrap:nowrap;align-items:center;overflow-x:auto;scrollbar-width:none;"}});
    listCont=cTasks.createDiv({attr:{style:"max-height:320px;overflow-y:auto;padding-right:4px;"}});
    monthCont=cTasks.createDiv({attr:{style:"display:none;"}});
    const calNavRow=monthCont.createDiv({attr:{style:"display:flex;align-items:center;justify-content:space-between;margin-bottom:14px;"}});
    const calNavL=calNavRow.createDiv({attr:{style:"cursor:pointer;opacity:0.5;font-size:1.3em;padding:4px 12px;border-radius:8px;transition:all 0.2s;user-select:none;"}});calNavL.innerText="‹";
    calNavL.onmouseenter=()=>{calNavL.style.opacity="1";calNavL.style.background=isDarkMode?"rgba(255,255,255,0.05)":"rgba(0,0,0,0.05)";};calNavL.onmouseleave=()=>{calNavL.style.opacity="0.5";calNavL.style.background=""};
    calTitleEl=calNavRow.createDiv({attr:{style:"font-size:0.85em;font-weight:800;letter-spacing:1.5px;"}});
    const calNavR=calNavRow.createDiv({attr:{style:"cursor:pointer;opacity:0.5;font-size:1.3em;padding:4px 12px;border-radius:8px;transition:all 0.2s;user-select:none;"}});calNavR.innerText="›";
    calNavR.onmouseenter=()=>{calNavR.style.opacity="1";calNavR.style.background=isDarkMode?"rgba(255,255,255,0.05)":"rgba(0,0,0,0.05)";};calNavR.onmouseleave=()=>{calNavR.style.opacity="0.5";calNavR.style.background=""};
    calGridEl=monthCont.createDiv({attr:{style:"display:grid;grid-template-columns:repeat(7,1fr);gap:5px;"}});
    calNavL.onclick=()=>{calViewDate=new Date(calViewDate.getFullYear(),calViewDate.getMonth()-1,1);renderMonth();};
    calNavR.onclick=()=>{calViewDate=new Date(calViewDate.getFullYear(),calViewDate.getMonth()+1,1);renderMonth();};
    return w;
}

// -- CTF CARD ----------------------------
const CATEGORY_COLORS={"web":"#00aaff","pwn":"#ff5555","crypto":"#b450ff","misc":"#ffc800","forensics":"#00ff88","reverse":"#ff8c00","stego":"#ff69b4","osint":"#00e5ff","hardware":"#aaaaaa"};
function getCTFCategory(title="",format=""){
    const t=(title+format).toLowerCase();
    if(t.includes("web"))return"web";if(t.includes("pwn")||t.includes("exploit"))return"pwn";
    if(t.includes("crypt"))return"crypto";if(t.includes("forensic"))return"forensics";
    if(t.includes("revers"))return"reverse";if(t.includes("stego"))return"stego";
    if(t.includes("osint"))return"osint";if(t.includes("hardware"))return"hardware";
    return"misc";
}
function fmtCTFDate(ts){return new Date(ts*1000).toLocaleDateString("en-US",{month:"short",day:"numeric",year:"numeric",hour:"2-digit",minute:"2-digit"});}
function ctfCountdown(endTs){
    const secs=endTs-(Date.now()/1000);
    if(secs<=0)return"Ended";
    const d=Math.floor(secs/86400),h=Math.floor((secs%86400)/3600),m=Math.floor((secs%3600)/60);
    if(d>0)return`${d}d ${h}h left`;if(h>0)return`${h}h ${m}m left`;return`${m}m left`;
}

let ctfListEl,ctfSummaryEl;

function buildCTFCard(){
    const w=makeRightCard("ctf");
    w.classList.add("zos-resizable-card");
    attachResizeHandle(w,"ctf",()=>rightCol);
    const cCTF=w.createDiv({cls:"zos-card",attr:{style:isDarkMode?"":"background:#ffffff;color:#0f0f0f;border-color:rgba(0,0,0,0.09);"}});
    const ctfHdr=cCTF.createDiv({cls:"zos-card-title",attr:{style:"justify-content:space-between;margin-bottom:0;"}});
    const ctfDrag=ctfHdr.createDiv({attr:{style:"cursor:grab;user-select:none;"}});
    ctfDrag.setAttribute("data-right-drag","true");
    ctfDrag.innerText="CTF TRACKER";
    ctfSummaryEl=cCTF.createDiv({attr:{style:"display:flex;gap:7px;margin:14px 0 18px;flex-wrap:wrap;align-items:center;"}});
    ctfListEl=cCTF.createDiv({attr:{style:"display:grid;grid-template-columns:1fr;gap:12px;max-height:320px;overflow-y:auto;padding-right:4px;"}});
    return w;
}

async function fetchCTFs(){
    if(!ctfListEl||!ctfSummaryEl)return;
    ctfListEl.innerHTML="";ctfSummaryEl.innerHTML="";
    ctfListEl.createDiv({attr:{style:"text-align:center;padding:24px;opacity:0.4;font-size:0.8em;"}}).innerText="Fetching CTFs...";
    try{
        const now=Math.floor(Date.now()/1000);
        const lookbackStart=now-(14*86400);
        const finish=now+(90*86400);
        const res=await request({url:`https://ctftime.org/api/v1/events/?limit=100&start=${lookbackStart}&finish=${finish}`,method:"GET",headers:{"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36","Accept":"application/json"}});
        const ctfEvents=JSON.parse(res);
        if(Array.isArray(ctfEvents)&&ctfEvents.length>0){
            localStorage.setItem("zos-ctf-cache",JSON.stringify(ctfEvents.slice(0,50)));
        }
        if(!Array.isArray(ctfEvents)||ctfEvents.length===0){
            ctfListEl.innerHTML="";ctfListEl.createDiv({cls:"zos-hint"}).innerText="No upcoming CTFs found.";return;
        }
        const filtered=ctfEvents.filter(ev=>{
            const fTs=new Date(ev.finish).getTime()/1000;
            const sTs=new Date(ev.start).getTime()/1000;
            // Must not have ended, and must start within 90 days
            return fTs>now && sTs<now+(90*86400);
        }).slice(0,20);
        const ongoing=filtered.filter(ev=>new Date(ev.start).getTime()/1000<=now);
        const upcoming=filtered.filter(ev=>new Date(ev.start).getTime()/1000>now);

        ctfSummaryEl.innerHTML="";
        let ctfFilter=null;
        const pillEls={};
        [{l:`${ongoing.length} Ongoing`,c:"#00ff88",bg:"rgba(0,255,136,0.08)",f:"ongoing"},
         {l:`${upcoming.length} Upcoming`,c:"var(--zos-accent)",bg:"rgba(var(--zos-accent-rgb),0.08)",f:"upcoming"},
         {l:`${filtered.filter(ev=>!!localStorage.getItem(`zos-ctf-reg-${ev.ctf_id}`)).length} Registered`,c:"#ffc800",bg:"rgba(255,200,0,0.08)",f:"registered"},
        ].forEach(p=>{
            const pill=ctfSummaryEl.createDiv({attr:{style:`font-size:0.65em;font-weight:700;padding:3px 9px;border-radius:20px;white-space:nowrap;color:${p.c};background:${p.bg};letter-spacing:0.4px;cursor:pointer;transition:all 0.2s;border:2px solid transparent;`}});
            pill.innerText=p.l;pillEls[p.f]=pill;
pill.setAttribute("data-ctf-pill",p.f);
pill.dataset.active="0";
if(p.f==="registered") pill.setAttribute("data-ctf-pill","registered");
            pill.onclick=()=>{
                ctfFilter=ctfFilter===p.f?null:p.f;
                Object.entries(pillEls).forEach(([f,el])=>{
                    el.style.borderColor=ctfFilter===f?p.c:"transparent";
                    el.dataset.active=ctfFilter===f?"1":"0";
                });
                ctfListEl.innerHTML="";
                if(ctfFilter==="registered"){
                    const regs=filtered.filter(ev=>!!localStorage.getItem(`zos-ctf-reg-${ev.ctf_id}`));
                    renderCTFGroup("REGISTERED","#ffc800",regs,now,filtered);
                }else{
                    if(ctfFilter==="ongoing"||ctfFilter===null)renderCTFGroup("ONGOING","#00ff88",ongoing,now);
                    if(ctfFilter==="upcoming"||ctfFilter===null)renderCTFGroup("UPCOMING","var(--zos-accent)",upcoming,now);
                }
                
                if(!ctfListEl.children.length){
                    const empty=ctfListEl.createDiv({attr:{style:"text-align:center;padding:32px 20px;opacity:0.5;font-size:0.9em;display:flex;flex-direction:column;align-items:center;"}});
                    empty.createDiv({attr:{style:"font-size:2em;margin-bottom:8px;"}}).innerText="🍃";
                    empty.createDiv({attr:{style:"font-weight:700;"}}).innerText="Nothing here at the moment.";
                }
                scheduleRightHeightSync();
            };
            pill.onmouseenter=()=>{pill.style.opacity="0.8";};pill.onmouseleave=()=>{pill.style.opacity="1";};
        });

        ctfListEl.innerHTML="";
        renderCTFGroup("ONGOING","#00ff88",ongoing,now,filtered);
		renderCTFGroup("UPCOMING","var(--zos-accent)",upcoming,now,filtered);
        
        if(!ctfListEl.children.length){
            const empty=ctfListEl.createDiv({attr:{style:"text-align:center;padding:32px 20px;opacity:0.5;font-size:0.9em;display:flex;flex-direction:column;align-items:center;"}});
            empty.createDiv({attr:{style:"font-size:2em;margin-bottom:8px;"}}).innerText="🍃";
            empty.createDiv({attr:{style:"font-weight:700;"}}).innerText="Nothing here at the moment.";
        }
    }catch(err){
        ctfListEl.innerHTML="";
        ctfListEl.createDiv({cls:"zos-hint"}).innerHTML=`Failed to fetch CTFs: ${err.message}`;
    }finally{
        scheduleRightHeightSync();
    }
}

function renderCTFGroup(label,color,evs,now,filteredEvs){
    if(!evs.length)return;
    const hdr=ctfListEl.createDiv({attr:{style:`display:flex;align-items:center;gap:8px;margin:8px 0 4px;padding-bottom:7px;border-bottom:1px solid ${isDarkMode?"rgba(255,255,255,0.05)":"rgba(0,0,0,0.07)"};`}});
    hdr.createDiv({attr:{style:`width:3px;height:14px;border-radius:2px;background:${color};flex-shrink:0;`}});
    hdr.createDiv({text:label,attr:{style:`font-size:0.7em;font-weight:800;letter-spacing:2px;color:${color};`}});
    hdr.createDiv({text:evs.length,attr:{style:`font-size:0.65em;font-weight:700;padding:2px 7px;border-radius:10px;background:${color}22;color:${color};margin-left:auto;`}});
    evs.forEach(ev=>{
        const cat=getCTFCategory(ev.title,ev.format||"");
        const catColor=CATEGORY_COLORS[cat]||"#888";
        const isOngoing=new Date(ev.start).getTime()/1000<=now;
        const card=ctfListEl.createDiv({attr:{style:`padding:14px 16px;background:${isDarkMode ? "rgba(255,255,255,0.025)" : "rgba(0,0,0,0.02)"};border-radius:14px;border:1px solid ${isOngoing?"rgba(0,255,136,0.15)":(isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.08)")};transition:all 0.2s;cursor:pointer;position:relative;overflow:hidden;`}});
        card.createDiv({attr:{style:`position:absolute;top:0;left:0;right:0;height:2px;background:${isOngoing?"#00ff88":catColor};opacity:0.6;`}});
        const topRow=card.createDiv({attr:{style:"display:flex;align-items:flex-start;justify-content:space-between;gap:8px;margin-bottom:8px;"}});
        topRow.createDiv({attr:{style:"font-weight:700;font-size:0.88em;line-height:1.3;flex:1;"}}).innerText=ev.title;
        const startTs=new Date(ev.start).getTime()/1000,finishTs=new Date(ev.finish).getTime()/1000;
        const countdown=topRow.createDiv({attr:{style:`font-size:0.65em;font-weight:800;padding:2px 8px;border-radius:8px;white-space:nowrap;color:${isOngoing?"#00ff88":"var(--zos-accent)"};background:${isOngoing?"rgba(0,255,136,0.12)":"rgba(var(--zos-accent-rgb),0.1)"};flex-shrink:0;font-family:var(--zos-font-mono);`}});
        countdown.innerText=isOngoing?ctfCountdown(finishTs):`Starts in ${ctfCountdown(startTs).replace(" left","")}`;
        const metaRow=card.createDiv({attr:{style:"display:flex;align-items:center;gap:6px;flex-wrap:wrap;margin-bottom:6px;"}});
        metaRow.createDiv({attr:{style:`font-size:0.62em;font-weight:700;padding:2px 7px;border-radius:6px;background:${catColor}22;color:${catColor};`}}).innerText=cat.toUpperCase();
        if(ev.format)metaRow.createDiv({attr:{style:"font-size:0.62em;opacity:0.4;font-weight:600;"}}).innerText=ev.format;
        if(ev.organizers?.length)metaRow.createDiv({attr:{style:"font-size:0.62em;opacity:0.35;"}}).innerText="by "+ev.organizers[0].name;
        card.createDiv({attr:{style:"font-size:0.67em;opacity:0.35;"}}).innerText=`${fmtCTFDate(startTs)} -> ${fmtCTFDate(finishTs)}`;
        card.onmouseenter=()=>{card.style.background=isDarkMode ? "rgba(255,255,255,0.04)" : "rgba(0,0,0,0.035)";card.style.borderColor=isOngoing?"rgba(0,255,136,0.3)":(isDarkMode ? "rgba(255,255,255,0.1)" : "rgba(0,0,0,0.12)");};
        card.onmouseleave=()=>{card.style.background=isDarkMode ? "rgba(255,255,255,0.025)" : "rgba(0,0,0,0.02)";card.style.borderColor=isOngoing?"rgba(0,255,136,0.15)":(isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.08)");};
        const regKey=`zos-ctf-reg-${ev.ctf_id}`;
        const isReg=!!localStorage.getItem(regKey);
        const regBtn=card.createDiv({attr:{style:`display:inline-flex;align-items:center;gap:5px;margin-top:8px;padding:4px 10px;border-radius:8px;font-size:0.65em;font-weight:700;cursor:pointer;transition:all 0.2s;background:${isReg?"rgba(0,255,136,0.12)":"rgba(255,255,255,0.04)"};color:${isReg?"#00ff88":"rgba(255,255,255,0.35)"};border:1px solid ${isReg?"rgba(0,255,136,0.25)":"rgba(255,255,255,0.08)"};`}});
        regBtn.innerText=isReg?"✓ Registered":"+ Register";
        regBtn.onclick=e=>{
    e.stopPropagation();
    const wasReg=!!localStorage.getItem(regKey);
    if(wasReg){localStorage.removeItem(regKey);regBtn.innerText="+ Register";regBtn.style.background="rgba(255,255,255,0.04)";regBtn.style.color="rgba(255,255,255,0.35)";regBtn.style.border="1px solid rgba(255,255,255,0.08)";}
    else{localStorage.setItem(regKey,"1");regBtn.innerText="✓ Registered";regBtn.style.background="rgba(0,255,136,0.12)";regBtn.style.color="#00ff88";regBtn.style.border="1px solid rgba(0,255,136,0.25)";}
    const regCount=filteredEvs.filter(ev=>!!localStorage.getItem(`zos-ctf-reg-${ev.ctf_id}`)).length;
    const regPill=ctfSummaryEl?.querySelector('[data-ctf-pill="registered"]');
    if(regPill) regPill.innerText=`${regCount} Registered`;
    if(wasReg && regPill?.dataset.active==="1"){
        card.style.opacity="0";card.style.transition="opacity 0.2s";
        setTimeout(()=>{
            card.remove();
            if(!ctfListEl.querySelector('[data-ctf-card]')){
                ctfListEl.innerHTML="";
                ctfListEl.createDiv({attr:{style:"text-align:center;padding:32px;opacity:0.4;font-size:0.85em;"}}).innerText="No registered CTFs.";
            }
            scheduleRightHeightSync();
        },200);
    }
};
card.setAttribute("data-ctf-card","1");
        card.onclick=async e=>{
    if(e.target===regBtn||regBtn.contains(e.target))return;
    const ov2=document.body.createDiv({cls:"zos-modal-overlay"});
    const mo2=ov2.createDiv({cls:"zos-modal",attr:{style:`width:500px;max-height:85vh;overflow-y:auto;background:${modalBg};${modalBlur}color:${modalText};border-color:${modalBorder};box-shadow:${modalShadow};`}});
    const cl2=()=>ov2.remove();
    ov2.onclick=e2=>{if(e2.target===ov2)cl2();};
    mo2.createDiv({cls:"zos-modal-title",attr:{style:`color:${modalText};`},text:"CTF DETAILS"});

    // Use list data directly — individual API returns stale cached dates
    const full=ev;

    const cat=getCTFCategory(full.title||ev.title,full.format||ev.format||"");
    const catColor=CATEGORY_COLORS[cat]||"#888";
    const sTs=new Date(full.start||ev.start).getTime()/1000;
    const fTs=new Date(full.finish||ev.finish).getTime()/1000;
    const nowTs=Math.floor(Date.now()/1000);
    const isActuallyLive=sTs<=nowTs&&fTs>nowTs;
    const isEnded=fTs<=nowTs;

    // Title + logo
    const titleRow=mo2.createDiv({attr:{style:"display:flex;align-items:center;gap:14px;margin-bottom:16px;"}});
    if(full.logo){
        const img=titleRow.createEl("img",{attr:{src:full.logo,style:"width:52px;height:52px;border-radius:12px;object-fit:cover;background:rgba(255,255,255,0.05);flex-shrink:0;"}});
        img.onerror=()=>img.remove();
    }
    const titleInfo=titleRow.createDiv({attr:{style:"flex:1;min-width:0;"}});
    titleInfo.createDiv({attr:{style:"font-weight:800;font-size:1.05em;line-height:1.3;margin-bottom:4px;"}}).innerText=full.title||ev.title;
    if(full.organizers?.length||ev.organizers?.length){
        const orgs=(full.organizers||ev.organizers).map(o=>o.name).join(", ");
        titleInfo.createDiv({attr:{style:"font-size:0.72em;opacity:0.4;"}}).innerText="by "+orgs;
    }

    // Status + countdown
    const statusRow=mo2.createDiv({attr:{style:"display:flex;gap:7px;flex-wrap:wrap;margin-bottom:14px;align-items:center;"}});
    const statusText=isEnded?"✅ ENDED":isActuallyLive?`🔴 LIVE — ${ctfCountdown(fTs)}`:`Starts in ${ctfCountdown(sTs).replace(" left","")}`;
    const statusColor=isEnded?"rgba(255,255,255,0.3)":isActuallyLive?"#00ff88":"var(--zos-accent)";
    const statusBg=isEnded?"rgba(255,255,255,0.05)":isActuallyLive?"rgba(0,255,136,0.12)":"rgba(var(--zos-accent-rgb),0.1)";
    statusRow.createDiv({attr:{style:`font-size:0.68em;font-weight:800;padding:3px 10px;border-radius:8px;background:${statusBg};color:${statusColor};font-family:var(--zos-font-mono);`}}).innerText=statusText;
    statusRow.createDiv({attr:{style:`font-size:0.65em;font-weight:800;padding:3px 9px;border-radius:8px;background:${catColor}22;color:${catColor};`}}).innerText=cat.toUpperCase();
    if(full.format||ev.format)statusRow.createDiv({attr:{style:`font-size:0.65em;font-weight:600;padding:3px 9px;border-radius:8px;background:${isDarkMode?"rgba(255,255,255,0.05)":"rgba(0,0,0,0.05)"};color:${isDarkMode?"rgba(255,255,255,0.5)":"rgba(0,0,0,0.55)"};`}}).innerText=full.format||ev.format;
    if((full.weight||0)>0)statusRow.createDiv({attr:{style:`font-size:0.65em;font-weight:600;padding:3px 9px;border-radius:8px;background:${isDarkMode?"rgba(255,255,255,0.05)":"rgba(0,0,0,0.05)"};color:${isDarkMode?"rgba(255,255,255,0.5)":"rgba(0,0,0,0.55)"};`}}).innerText=`Weight: ${full.weight}`;

    // Dates
    const dateBox=mo2.createDiv({attr:{style:`background:${isDarkMode ? "rgba(255,255,255,0.03)" : "rgba(0,0,0,0.02)"};border:1px solid ${isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.08)"};border-radius:12px;padding:12px 14px;margin-bottom:14px;display:grid;grid-template-columns:1fr 1fr;gap:8px;`}});
    [{l:"Starts",v:fmtCTFDate(sTs)},{l:"Ends",v:fmtCTFDate(fTs)},{l:"Duration",v:(()=>{const h=Math.round((fTs-sTs)/3600);return h>=24?`${Math.floor(h/24)}d ${h%24}h`:`${h}h`;})()},{l:"Location",v:full.onsite?"On-site":"Online"}].forEach(({l,v})=>{
        const cell=dateBox.createDiv();
        cell.createDiv({attr:{style:"font-size:0.58em;font-weight:700;letter-spacing:1px;opacity:0.3;margin-bottom:2px;"}}).innerText=l.toUpperCase();
        cell.createDiv({attr:{style:"font-size:0.75em;font-weight:600;"}}).innerText=v;
    });

    // URL
    if(full.url||full.ctftime_url){
        const urlBox=mo2.createDiv({attr:{style:`background:${isDarkMode ? "rgba(255,255,255,0.03)" : "rgba(0,0,0,0.02)"};border:1px solid ${isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.08)"};border-radius:12px;padding:10px 14px;margin-bottom:14px;`}});
        urlBox.createDiv({attr:{style:"font-size:0.58em;font-weight:700;letter-spacing:1px;opacity:0.3;margin-bottom:4px;"}}).innerText="WEBSITE";
        const urlLink=urlBox.createDiv({attr:{style:"font-size:0.78em;color:var(--zos-accent);cursor:pointer;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"}});
        urlLink.innerText=full.url||full.ctftime_url;
        urlLink.onclick=()=>window.open(full.url||full.ctftime_url,"_blank");
        urlLink.onmouseenter=()=>{urlLink.style.textDecoration="underline";};
        urlLink.onmouseleave=()=>{urlLink.style.textDecoration="";};
    }

    // Description
    const desc=((full.description||ev.description||"").replace(/<[^>]+>/g," ").replace(/&[a-z]+;/g," ").replace(/\s+/g," ").trim());
    if(desc){
        const descBox=mo2.createDiv({attr:{style:"margin-bottom:14px;"}});
        descBox.createDiv({attr:{style:"font-size:0.58em;font-weight:700;letter-spacing:1px;opacity:0.3;margin-bottom:6px;"}}).innerText="DESCRIPTION";
        descBox.createDiv({attr:{style:`font-size:0.8em;opacity:0.7;line-height:1.7;background:${isDarkMode ? "rgba(255,255,255,0.03)" : "rgba(0,0,0,0.02)"};border-radius:12px;padding:12px;border:1px solid ${isDarkMode ? "rgba(255,255,255,0.05)" : "rgba(0,0,0,0.08)"};max-height:140px;overflow-y:auto;white-space:pre-wrap;`}}).innerText=desc;
    }

    // Prizes
    if(full.prizes){
        const prizeBox=mo2.createDiv({attr:{style:"margin-bottom:14px;"}});
        prizeBox.createDiv({attr:{style:"font-size:0.58em;font-weight:700;letter-spacing:1px;opacity:0.3;margin-bottom:6px;"}}).innerText="PRIZES";
        prizeBox.createDiv({attr:{style:`font-size:0.8em;opacity:0.7;line-height:1.7;background:${isDarkMode ? "rgba(255,255,255,0.03)" : "rgba(0,0,0,0.02)"};border-radius:12px;padding:12px;border:1px solid ${isDarkMode ? "rgba(255,255,255,0.05)" : "rgba(0,0,0,0.08)"};`}}).innerText=full.prizes.replace(/<[^>]+>/g," ").trim();
    }

    // Restrictions
    if(full.restrictions){
        const restRow=mo2.createDiv({attr:{style:"margin-bottom:14px;"}});
        restRow.createDiv({attr:{style:"font-size:0.58em;font-weight:700;letter-spacing:1px;opacity:0.3;margin-bottom:4px;"}}).innerText="RESTRICTIONS";
        restRow.createDiv({attr:{style:"font-size:0.78em;opacity:0.5;"}}).innerText=full.restrictions;
    }

    // Tags / participants
    const statsRow=mo2.createDiv({attr:{style:"display:flex;gap:7px;flex-wrap:wrap;margin-bottom:16px;"}});
    if(full.participants)statsRow.createDiv({attr:{style:`font-size:0.65em;padding:3px 9px;border-radius:8px;background:${isDarkMode?"rgba(255,255,255,0.04)":"rgba(0,0,0,0.05)"};color:${isDarkMode?"rgba(255,255,255,0.45)":"rgba(0,0,0,0.5)"};`}}).innerText=`👥 ${full.participants} participants`;
    if(full.is_votable_now)statsRow.createDiv({attr:{style:"font-size:0.65em;padding:3px 9px;border-radius:8px;background:rgba(0,200,100,0.1);color:#00a050;"}}).innerText="✓ Votable";
    if(full.individual)statsRow.createDiv({attr:{style:`font-size:0.65em;padding:3px 9px;border-radius:8px;background:${isDarkMode?"rgba(255,255,255,0.04)":"rgba(0,0,0,0.05)"};color:${isDarkMode?"rgba(255,255,255,0.45)":"rgba(0,0,0,0.5)"};`}}).innerText="👤 Individual";

    // Buttons
    const btnRow=mo2.createDiv({attr:{style:"display:flex;gap:8px;margin-bottom:8px;"}});
    const regKey=`zos-ctf-reg-${ev.ctf_id}`;
    const isRegNow=!!localStorage.getItem(regKey);
    const regBtnModal=btnRow.createEl("button",{attr:{style:`flex:1;font-size:0.75em;font-weight:700;padding:9px;border-radius:9px;background:${isRegNow?"rgba(0,200,100,0.1)":(isDarkMode?"rgba(255,255,255,0.05)":"rgba(0,0,0,0.05)")};color:${isRegNow?(isDarkMode?"#00ff88":"#00a050"):(isDarkMode?"rgba(255,255,255,0.5)":"rgba(0,0,0,0.5)")};border:1px solid ${isRegNow?"rgba(0,200,100,0.25)":(isDarkMode?"rgba(255,255,255,0.08)":"rgba(0,0,0,0.1)")};cursor:pointer;transition:all 0.2s;`}});
    regBtnModal.innerText=isRegNow?"✓ Registered":"+ Register";
    regBtnModal.onclick=()=>{
        const wasReg=!!localStorage.getItem(regKey);
        if(wasReg){localStorage.removeItem(regKey);regBtnModal.innerText="+ Register";regBtnModal.style.background="rgba(255,255,255,0.05)";regBtnModal.style.color="rgba(255,255,255,0.5)";regBtnModal.style.borderColor="rgba(255,255,255,0.08)";}
        else{localStorage.setItem(regKey,"1");regBtnModal.innerText="✓ Registered";regBtnModal.style.background="rgba(0,255,136,0.12)";regBtnModal.style.color="#00ff88";regBtnModal.style.borderColor="rgba(0,255,136,0.25)";}
        fetchCTFs();
    };
    if(full.url||ev.url){
        const ob=btnRow.createEl("button",{attr:{style:`flex:1;font-size:0.75em;font-weight:700;padding:9px;border-radius:9px;background:rgba(var(--zos-accent-rgb),0.1);color:var(--zos-accent);border:1px solid rgba(var(--zos-accent-rgb),0.2);cursor:pointer;`}});
        ob.innerText="↗ Official Site";
        ob.onclick=()=>window.open(full.url||ev.url,"_blank");
    }
    if(full.ctftime_url||ev.ctftime_url){
        const ct=btnRow.createEl("button",{attr:{style:`flex:1;font-size:0.75em;font-weight:700;padding:9px;border-radius:9px;background:${isDarkMode?"rgba(255,255,255,0.04)":"rgba(0,0,0,0.05)"};color:${isDarkMode?"rgba(255,255,255,0.5)":"rgba(0,0,0,0.5)"};border:1px solid ${isDarkMode?"rgba(255,255,255,0.08)":"rgba(0,0,0,0.1)"};cursor:pointer;`}});
        ct.innerText="CTFtime ↗";
        ct.onclick=()=>window.open(full.ctftime_url||ev.ctftime_url,"_blank");
    }
    mo2.createEl("button",{cls:"zos-modal-btn zos-btn-cancel",attr:{style:`width:100%;background:${isDarkMode?"rgba(255,255,255,0.05)":"rgba(0,0,0,0.05)"};color:${isDarkMode?"rgba(255,255,255,0.6)":"rgba(0,0,0,0.6)"};border:1px solid ${isDarkMode?"rgba(255,255,255,0.1)":"rgba(0,0,0,0.1)"};`},text:"Close"}).onclick=cl2;
};
    });
}

// -- AI NEWS CARD ----------------------------
const AI_NEWS_SOURCES=[
    {id:"hn",label:"Hacker News",color:"#ff6600",url:"https://hn.algolia.com/api/v1/search_by_date?query=AI+OR+LLM+OR+Claude+OR+GPT+OR+OpenAI+OR+Anthropic&tags=story&hitsPerPage=15"},
    {id:"verge",label:"The Verge",color:"#fa4b2a",rss:"https://www.theverge.com/rss/ai-artificial-intelligence/index.xml"},
    {id:"techcrunch",label:"TechCrunch",color:"#0a9952",rss:"https://techcrunch.com/category/artificial-intelligence/feed/"},
];
let aiNewsListEl,aiNewsSummaryEl;

function buildAINewsCard(){
    const w=makeRightCard("ainews");
    w.classList.add("zos-resizable-card");
    attachResizeHandle(w,"ainews",()=>rightCol);
    const cNews=w.createDiv({cls:"zos-card",attr:{style:isDarkMode?"":"background:#ffffff;color:#0f0f0f;border-color:rgba(0,0,0,0.09);"}});
    const newsHdr=cNews.createDiv({cls:"zos-card-title",attr:{style:"justify-content:space-between;margin-bottom:0;"}});
    const newsDrag=newsHdr.createDiv({attr:{style:"cursor:grab;user-select:none;"}});
    newsDrag.setAttribute("data-right-drag","true");
    newsDrag.innerText="AI NEWS";
    aiNewsSummaryEl=cNews.createDiv({attr:{style:"display:flex;gap:7px;margin:14px 0 18px;flex-wrap:wrap;align-items:center;"}});
    aiNewsListEl=cNews.createDiv({attr:{style:"display:grid;grid-template-columns:1fr;gap:10px;max-height:400px;overflow-y:auto;padding-right:4px;"}});
    return w;
}

function fmtNewsDate(dateStr){
    const d=new Date(dateStr);
    const now=new Date();
    const diffMs=now-d;
    const diffH=Math.floor(diffMs/3600000);
    if(diffH<1)return`${Math.floor(diffMs/60000)}m ago`;
    if(diffH<24)return`${diffH}h ago`;
    const diffD=Math.floor(diffH/24);
    if(diffD<7)return`${diffD}d ago`;
    return d.toLocaleDateString("en-US",{month:"short",day:"numeric"});
}

async function parseRSS(url){
    try{
        const res=await request({url,method:"GET",headers:{"Accept":"application/rss+xml,application/xml,text/xml"}});
        const parser=new DOMParser();
        const doc=parser.parseFromString(res,"text/xml");
        const items=doc.querySelectorAll("item");
        return Array.from(items).slice(0,15).map(item=>({
            title:(item.querySelector("title")?.textContent||"").trim(),
            link:(item.querySelector("link")?.textContent||"").trim(),
            date:item.querySelector("pubDate")?.textContent||"",
        }));
    }catch(e){console.error("RSS fetch error:",url,e);return[];}
}

async function fetchAINews(){
    if(!aiNewsListEl||!aiNewsSummaryEl)return;
    aiNewsListEl.innerHTML="";aiNewsSummaryEl.innerHTML="";
    aiNewsListEl.createDiv({attr:{style:"text-align:center;padding:24px;opacity:0.4;font-size:0.8em;"}}).innerText="Fetching AI news...";
    try{
        const allArticles=[];
        // Hacker News (JSON API)
        const hnSource=AI_NEWS_SOURCES.find(s=>s.id==="hn");
        try{
            const hnRes=await request({url:hnSource.url,method:"GET",headers:{"Accept":"application/json"}});
            const hnData=JSON.parse(hnRes);
            (hnData.hits||[]).forEach(h=>allArticles.push({
                title:h.title||"",link:h.url||`https://news.ycombinator.com/item?id=${h.objectID}`,
                date:h.created_at||"",source:"hn",points:h.points||0,comments:h.num_comments||0,
            }));
        }catch(e){console.error("HN fetch error:",e);}
        // RSS sources
        for(const src of AI_NEWS_SOURCES.filter(s=>s.rss)){
            const items=await parseRSS(src.rss);
            items.forEach(item=>allArticles.push({...item,source:src.id}));
        }
        // Sort by date descending
        allArticles.sort((a,b)=>new Date(b.date)-new Date(a.date));
        // Cache
        localStorage.setItem("zos-ainews-cache",JSON.stringify(allArticles.slice(0,50)));
        // Summary pills
        aiNewsSummaryEl.innerHTML="";
        let activeFilter=null;
        const pillEls={};
        [{id:"all",l:`${allArticles.length} All`,c:"var(--zos-accent)",bg:"rgba(var(--zos-accent-rgb),0.08)"},...AI_NEWS_SOURCES.map(s=>({id:s.id,l:s.label,c:s.color,bg:`${s.color}18`}))].forEach(p=>{
            const pill=aiNewsSummaryEl.createDiv({attr:{style:`font-size:0.65em;font-weight:700;padding:3px 9px;border-radius:20px;white-space:nowrap;color:${p.c};background:${p.bg};letter-spacing:0.4px;cursor:pointer;transition:all 0.2s;border:2px solid ${p.id==="all"?p.c:"transparent"};`}});
            pill.innerText=p.l;pillEls[p.id]=pill;
            pill.onclick=()=>{
                activeFilter=activeFilter===p.id||p.id==="all"?null:p.id;
                Object.entries(pillEls).forEach(([id,el])=>{
                    el.style.borderColor=(activeFilter===id||(activeFilter===null&&id==="all"))?pillEls[id===activeFilter?id:"all"]?.style.color||p.c:"transparent";
                });
                renderAINews(activeFilter?allArticles.filter(a=>a.source===activeFilter):allArticles);
            };
            pill.onmouseenter=()=>{pill.style.opacity="0.8";};pill.onmouseleave=()=>{pill.style.opacity="1";};
        });
        renderAINews(allArticles);
    }catch(err){
        aiNewsListEl.innerHTML="";
        aiNewsListEl.createDiv({cls:"zos-hint"}).innerHTML=`Failed to fetch AI news: ${err.message}`;
    }finally{
        scheduleRightHeightSync();
    }
}

function renderAINews(articles){
    aiNewsListEl.innerHTML="";
    if(!articles.length){
        const empty=aiNewsListEl.createDiv({attr:{style:"text-align:center;padding:32px 20px;opacity:0.5;font-size:0.9em;display:flex;flex-direction:column;align-items:center;"}});
        empty.createDiv({attr:{style:"font-size:2em;margin-bottom:8px;"}}).innerText="📰";
        empty.createDiv({attr:{style:"font-weight:700;"}}).innerText="No news found.";
        return;
    }
    articles.slice(0,20).forEach(article=>{
        const srcInfo=AI_NEWS_SOURCES.find(s=>s.id===article.source)||{label:"News",color:"#888"};
        const card=aiNewsListEl.createDiv({attr:{style:`padding:12px 14px;background:${isDarkMode?"rgba(255,255,255,0.025)":"rgba(0,0,0,0.02)"};border-radius:12px;border:1px solid ${isDarkMode?"rgba(255,255,255,0.06)":"rgba(0,0,0,0.08)"};transition:all 0.2s;cursor:pointer;position:relative;overflow:hidden;`}});
        card.createDiv({attr:{style:`position:absolute;top:0;left:0;right:0;height:2px;background:${srcInfo.color};opacity:0.5;`}});
        const titleEl=card.createDiv({attr:{style:"font-weight:700;font-size:0.85em;line-height:1.4;margin-bottom:6px;"}});
        titleEl.innerText=article.title;
        const metaRow=card.createDiv({attr:{style:"display:flex;align-items:center;gap:6px;flex-wrap:wrap;"}});
        metaRow.createDiv({attr:{style:`font-size:0.6em;font-weight:700;padding:2px 7px;border-radius:6px;background:${srcInfo.color}22;color:${srcInfo.color};`}}).innerText=srcInfo.label.toUpperCase();
        if(article.date)metaRow.createDiv({attr:{style:"font-size:0.62em;opacity:0.4;font-weight:600;"}}).innerText=fmtNewsDate(article.date);
        if(article.source==="hn"&&article.points)metaRow.createDiv({attr:{style:"font-size:0.6em;opacity:0.35;"}}).innerText=`▲ ${article.points}`;
        if(article.source==="hn"&&article.comments)metaRow.createDiv({attr:{style:"font-size:0.6em;opacity:0.35;"}}).innerText=`💬 ${article.comments}`;
        card.onmouseenter=()=>{card.style.background=isDarkMode?"rgba(255,255,255,0.04)":"rgba(0,0,0,0.035)";card.style.borderColor=isDarkMode?"rgba(255,255,255,0.1)":"rgba(0,0,0,0.12)";};
        card.onmouseleave=()=>{card.style.background=isDarkMode?"rgba(255,255,255,0.025)":"rgba(0,0,0,0.02)";card.style.borderColor=isDarkMode?"rgba(255,255,255,0.06)":"rgba(0,0,0,0.08)";};
        card.onclick=()=>{if(article.link)window.open(article.link,"_blank");};
    });
}

// -- GITHUB ACTIVITY CARD ----------------------------
const GH_EVENT_ICONS={PushEvent:"📝",PullRequestEvent:"🔀",IssuesEvent:"🐛",CreateEvent:"🌿",DeleteEvent:"🗑",WatchEvent:"⭐",ForkEvent:"🍴",ReleaseEvent:"🚀",PullRequestReviewEvent:"👀",IssueCommentEvent:"💬",PullRequestReviewCommentEvent:"💬"};
const GH_EVENT_LABELS={PushEvent:"Push",PullRequestEvent:"PR",IssuesEvent:"Issue",CreateEvent:"Create",DeleteEvent:"Delete",WatchEvent:"Star",ForkEvent:"Fork",ReleaseEvent:"Release",PullRequestReviewEvent:"Review",IssueCommentEvent:"Comment",PullRequestReviewCommentEvent:"Review Comment"};
let ghListEl,ghSummaryEl,ghUsernameEl;

function buildGitHubCard(){
    const w=makeCard("github");
    const cGH=w.createDiv({cls:"zos-card",attr:{style:isDarkMode?"":"background:#ffffff;color:#0f0f0f;border-color:rgba(0,0,0,0.09);"}});
    const ghHdr=cGH.createDiv({cls:"zos-card-title",attr:{style:"justify-content:space-between;margin-bottom:0;"}});
    const ghDrag=ghHdr.createDiv({attr:{style:"cursor:grab;user-select:none;display:flex;align-items:center;gap:8px;"}});
    ghDrag.setAttribute("data-drag-handle","true");
    ghDrag.innerText="GITHUB";
    // Username config button
    const ghCfgBtn=ghHdr.createDiv({attr:{style:"cursor:pointer;opacity:0.4;font-size:0.75em;transition:opacity 0.2s;"}});
    ghCfgBtn.innerText="⚙";
    ghCfgBtn.onmouseenter=()=>{ghCfgBtn.style.opacity="1";};
    ghCfgBtn.onmouseleave=()=>{ghCfgBtn.style.opacity="0.4";};
    ghCfgBtn.onclick=()=>{
        modal({title:"GitHub Username",value:localStorage.getItem("zos-github-username")||"",placeholder:"e.g. octocat",onSave:v=>{
            if(v.trim()){localStorage.setItem("zos-github-username",v.trim());fetchGitHub();}
        }});
    };
    ghSummaryEl=cGH.createDiv({attr:{style:"display:flex;gap:7px;margin:14px 0 18px;flex-wrap:wrap;align-items:center;"}});
    ghListEl=cGH.createDiv({attr:{style:"display:grid;grid-template-columns:1fr;gap:8px;max-height:240px;overflow-y:auto;padding-right:4px;"}});
    return w;
}

function getGHEventDetail(ev){
    switch(ev.type){
        case"PushEvent":
            const commits=ev.payload?.commits||[];
            return commits.length?commits.map(c=>c.message.split("\n")[0]).slice(0,3).join("; "):`${commits.length} commits`;
        case"PullRequestEvent":
            return `${ev.payload?.action||""}: ${ev.payload?.pull_request?.title||""}`;
        case"IssuesEvent":
            return `${ev.payload?.action||""}: ${ev.payload?.issue?.title||""}`;
        case"CreateEvent":
            return `${ev.payload?.ref_type||""} ${ev.payload?.ref||""}`;
        case"PullRequestReviewEvent":
            return ev.payload?.pull_request?.title||"";
        case"IssueCommentEvent":
            return ev.payload?.issue?.title||"";
        case"ReleaseEvent":
            return ev.payload?.release?.name||ev.payload?.release?.tag_name||"";
        case"ForkEvent":
            return ev.payload?.forkee?.full_name||"";
        default:return"";
    }
}

function getGHEventLink(ev){
    switch(ev.type){
        case"PushEvent":return`https://github.com/${ev.repo?.name}/commits`;
        case"PullRequestEvent":return ev.payload?.pull_request?.html_url||"";
        case"IssuesEvent":return ev.payload?.issue?.html_url||"";
        case"IssueCommentEvent":return ev.payload?.comment?.html_url||ev.payload?.issue?.html_url||"";
        case"PullRequestReviewEvent":return ev.payload?.pull_request?.html_url||"";
        case"ReleaseEvent":return ev.payload?.release?.html_url||"";
        default:return`https://github.com/${ev.repo?.name}`;
    }
}

async function fetchGitHub(){
    if(!ghListEl||!ghSummaryEl)return;
    const username=localStorage.getItem("zos-github-username")||"";
    if(!username){
        ghListEl.innerHTML="";ghSummaryEl.innerHTML="";
        const hint=ghListEl.createDiv({attr:{style:"text-align:center;padding:32px 20px;opacity:0.5;font-size:0.85em;"}});
        hint.innerText="⚙ 버튼을 눌러 GitHub 유저명을 설정하세요.";
        return;
    }
    ghListEl.innerHTML="";ghSummaryEl.innerHTML="";
    ghListEl.createDiv({attr:{style:"text-align:center;padding:24px;opacity:0.4;font-size:0.8em;"}}).innerText="Fetching GitHub activity...";
    try{
        const resp=await request({url:`https://api.github.com/users/${encodeURIComponent(username)}/events?per_page=30`,method:"GET",headers:{"Accept":"application/vnd.github.v3+json","User-Agent":"Obsidian-Dashboard"}});
        const events=JSON.parse(resp);
        if(!Array.isArray(events)||events.length===0){
            ghListEl.innerHTML="";ghListEl.createDiv({attr:{style:"text-align:center;padding:32px;opacity:0.4;font-size:0.85em;"}}).innerText="No recent activity.";return;
        }
        localStorage.setItem("zos-github-cache",JSON.stringify(events.slice(0,30)));
        // Summary pills
        ghSummaryEl.innerHTML="";
        const typeCounts={};
        events.forEach(ev=>{const t=ev.type;typeCounts[t]=(typeCounts[t]||0)+1;});
        let ghFilter=null;
        const pillEls={};
        const allPill=ghSummaryEl.createDiv({attr:{style:`font-size:0.65em;font-weight:700;padding:3px 9px;border-radius:20px;white-space:nowrap;color:var(--zos-accent);background:rgba(var(--zos-accent-rgb),0.08);letter-spacing:0.4px;cursor:pointer;transition:all 0.2s;border:2px solid var(--zos-accent);`}});
        allPill.innerText=`${events.length} All`;pillEls["all"]=allPill;
        [{type:"PushEvent",c:"#3fb950"},{type:"PullRequestEvent",c:"#a371f7"},{type:"IssuesEvent",c:"#f85149"}].forEach(p=>{
            if(!typeCounts[p.type])return;
            const pill=ghSummaryEl.createDiv({attr:{style:`font-size:0.65em;font-weight:700;padding:3px 9px;border-radius:20px;white-space:nowrap;color:${p.c};background:${p.c}18;letter-spacing:0.4px;cursor:pointer;transition:all 0.2s;border:2px solid transparent;`}});
            pill.innerText=`${typeCounts[p.type]} ${GH_EVENT_LABELS[p.type]||p.type}`;pillEls[p.type]=pill;
            pill.onclick=()=>{
                ghFilter=ghFilter===p.type?null:p.type;
                Object.entries(pillEls).forEach(([k,el])=>{el.style.borderColor=ghFilter===k?el.style.color:(k==="all"&&!ghFilter?"var(--zos-accent)":"transparent");});
                renderGHEvents(ghFilter?events.filter(e=>e.type===ghFilter):events);
            };
            pill.onmouseenter=()=>{pill.style.opacity="0.8";};pill.onmouseleave=()=>{pill.style.opacity="1";};
        });
        allPill.onclick=()=>{ghFilter=null;Object.entries(pillEls).forEach(([k,el])=>{el.style.borderColor=k==="all"?"var(--zos-accent)":"transparent";});renderGHEvents(events);};
        allPill.onmouseenter=()=>{allPill.style.opacity="0.8";};allPill.onmouseleave=()=>{allPill.style.opacity="1";};
        renderGHEvents(events);
    }catch(err){
        ghListEl.innerHTML="";
        ghListEl.createDiv({cls:"zos-hint"}).innerHTML=`Failed to fetch GitHub: ${err.message}`;
    }finally{
        scheduleRightHeightSync();
    }
}

function renderGHEvents(events){
    ghListEl.innerHTML="";
    if(!events.length){
        ghListEl.createDiv({attr:{style:"text-align:center;padding:32px;opacity:0.4;font-size:0.85em;"}}).innerText="No events.";return;
    }
    // Group by date
    const groups={};
    events.forEach(ev=>{
        const d=new Date(ev.created_at).toLocaleDateString("en-US",{month:"short",day:"numeric"});
        if(!groups[d])groups[d]=[];
        groups[d].push(ev);
    });
    Object.entries(groups).forEach(([date,evs])=>{
        const hdr=ghListEl.createDiv({attr:{style:`display:flex;align-items:center;gap:8px;margin:8px 0 4px;padding-bottom:5px;border-bottom:1px solid ${isDarkMode?"rgba(255,255,255,0.05)":"rgba(0,0,0,0.07)"};`}});
        hdr.createDiv({attr:{style:"width:3px;height:14px;border-radius:2px;background:var(--zos-accent);flex-shrink:0;"}});
        hdr.createDiv({text:date,attr:{style:"font-size:0.7em;font-weight:800;letter-spacing:2px;color:var(--zos-accent);"}});
        hdr.createDiv({text:evs.length,attr:{style:"font-size:0.65em;font-weight:700;padding:2px 7px;border-radius:10px;background:rgba(var(--zos-accent-rgb),0.1);color:var(--zos-accent);margin-left:auto;"}});
        evs.forEach(ev=>{
            const icon=GH_EVENT_ICONS[ev.type]||"📌";
            const label=GH_EVENT_LABELS[ev.type]||ev.type.replace("Event","");
            const detail=getGHEventDetail(ev);
            const repoName=(ev.repo?.name||"").split("/").pop();
            const link=getGHEventLink(ev);
            const typeColor=ev.type==="PushEvent"?"#3fb950":ev.type==="PullRequestEvent"?"#a371f7":ev.type==="IssuesEvent"?"#f85149":"var(--zos-accent)";
            const card=ghListEl.createDiv({attr:{style:`padding:10px 12px;background:${isDarkMode?"rgba(255,255,255,0.025)":"rgba(0,0,0,0.02)"};border-radius:12px;border:1px solid ${isDarkMode?"rgba(255,255,255,0.06)":"rgba(0,0,0,0.08)"};transition:all 0.2s;cursor:pointer;`}});
            const topRow=card.createDiv({attr:{style:"display:flex;align-items:center;gap:8px;margin-bottom:4px;"}});
            topRow.createDiv({attr:{style:"font-size:0.85em;"}}).innerText=icon;
            topRow.createDiv({attr:{style:`font-size:0.62em;font-weight:700;padding:2px 7px;border-radius:6px;background:${typeColor}22;color:${typeColor};`}}).innerText=label.toUpperCase();
            topRow.createDiv({attr:{style:"font-size:0.62em;opacity:0.4;font-weight:600;margin-left:auto;"}}).innerText=repoName;
            if(detail){
                card.createDiv({attr:{style:"font-size:0.78em;opacity:0.7;line-height:1.4;overflow:hidden;text-overflow:ellipsis;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;"}}).innerText=detail;
            }
            card.onmouseenter=()=>{card.style.background=isDarkMode?"rgba(255,255,255,0.04)":"rgba(0,0,0,0.035)";card.style.borderColor=isDarkMode?"rgba(255,255,255,0.1)":"rgba(0,0,0,0.12)";};
            card.onmouseleave=()=>{card.style.background=isDarkMode?"rgba(255,255,255,0.025)":"rgba(0,0,0,0.02)";card.style.borderColor=isDarkMode?"rgba(255,255,255,0.06)":"rgba(0,0,0,0.08)";};
            card.onclick=()=>{if(link)window.open(link,"_blank");};
        });
    });
}

// -- LINKS CARD ----------------
function buildLinksCard(){
    let linksData = JSON.parse(localStorage.getItem("zos-links-data") || "[]");
    const saveLinks = () => localStorage.setItem("zos-links-data", JSON.stringify(linksData));

    const w = makeCard("links");
    const cLinks = w.createDiv({cls: "zos-card",attr:{style:isDarkMode?"":"background:#ffffff;color:#0f0f0f;border-color:rgba(0,0,0,0.09);"}});

    // -- HEADER ----------------
    const hdr = cLinks.createDiv({cls: "zos-card-title", attr: {style: "justify-content:space-between;margin-bottom:0;"}});
    const dragHandle = hdr.createDiv({attr: {style: "cursor:grab;user-select:none;"}});
    dragHandle.setAttribute("data-drag-handle", "true");
    dragHandle.innerText = "QUICK LINKS";

    const hdrRight = hdr.createDiv({attr: {style: "display:flex;align-items:center;gap:6px;"}});
    const addBtn = hdrRight.createEl("button", {attr: {style: "font-size:0.65em;font-weight:700;padding:3px 10px;border-radius:8px;background:rgba(var(--zos-accent-rgb),0.1);color:var(--zos-accent);border:1px solid rgba(var(--zos-accent-rgb),0.25);cursor:pointer;transition:all 0.2s;letter-spacing:0.5px;"}});
    addBtn.innerText = "+ ADD";
    addBtn.onmouseenter = () => { addBtn.style.background="rgba(var(--zos-accent-rgb),0.2)"; };
    addBtn.onmouseleave = () => { addBtn.style.background="rgba(var(--zos-accent-rgb),0.1)"; };

    // -- CATEGORY FILTER BAR -------------
    const filterBar = cLinks.createDiv({attr: {style: "display:flex;gap:6px;margin:14px 0 16px;flex-wrap:wrap;align-items:center;overflow-x:auto;scrollbar-width:none;"}});

    // -- LINKS GRID ----------------
    const linksGrid = cLinks.createDiv({attr: {style: "display:flex;flex-direction:column;gap:4px;max-height:200px;overflow-y:auto;padding-right:4px;"}});

    let activeCategory = null;
    const catColors = ["#6366f1","#00aaff","#ff5555","#00ff88","#ffc800","#b450ff","#ff8c00","#00e5ff","#ff69b4"];

    const getFavicon = (url) => {
        try { return `https://www.google.com/s2/favicons?domain=${new URL(url).hostname}&sz=32`; }
        catch(e) { return ""; }
    };

    // -- DRAG-TO-REORDER STATE -----------
    let dragSrcIdx = null;
    let dragOverIdx = null;

    // -- RENDER ----------------
    const render = () => {
        filterBar.innerHTML = "";
        linksGrid.innerHTML = "";

        const allCats = [...new Set(linksData.map(l => l.category || "General"))];

        // Filter pills
        const pillInactiveBg = isDarkMode ? "rgba(255,255,255,0.04)" : "rgba(0,0,0,0.05)";
        const pillInactiveColor = isDarkMode ? "rgba(255,255,255,0.4)" : "rgba(0,0,0,0.5)";
        const makePill = (label, isActive, onClick) => {
            const pill = filterBar.createEl("button", {attr: {style: `font-size:0.62em;font-weight:700;padding:3px 10px;border-radius:20px;cursor:pointer;transition:all 0.2s;white-space:nowrap;border:2px solid ${isActive?"var(--zos-accent)":"transparent"};background:${isActive?"rgba(var(--zos-accent-rgb),0.12)":pillInactiveBg};color:${isActive?"var(--zos-accent)":pillInactiveColor};`}});
            pill.innerText = label;
            pill.onclick = onClick;
            pill.onmouseenter = () => { if(!isActive){pill.style.color=isDarkMode?"rgba(255,255,255,0.7)":"rgba(0,0,0,0.75)";pill.style.background=isDarkMode?"rgba(255,255,255,0.07)":"rgba(0,0,0,0.08)";} };
            pill.onmouseleave = () => { if(!isActive){pill.style.color=pillInactiveColor;pill.style.background=pillInactiveBg;} };
            return pill;
        };

        makePill("All", activeCategory===null, () => { activeCategory=null; render(); });
        allCats.forEach(cat => makePill(cat, activeCategory===cat, () => { activeCategory = activeCategory===cat ? null : cat; render(); }));

        // Filter
        const filtered = activeCategory
            ? linksData.map((l,i)=>({l,i})).filter(({l}) => (l.category||"General")===activeCategory)
            : linksData.map((l,i)=>({l,i}));

        if (!filtered.length) {
            const empty = linksGrid.createDiv({attr: {style: "grid-column:1/-1;text-align:center;padding:40px 20px;display:flex;flex-direction:column;align-items:center;gap:8px;"}});
            empty.createDiv({attr: {style: "font-size:2em;"}}).innerText = "🔗";
            empty.createDiv({attr: {style: "font-size:0.8em;opacity:0.4;font-weight:600;"}}).innerText = linksData.length ? "No links in this category." : "No links yet. Hit + ADD to start.";
            return;
        }

        filtered.forEach(({l: link, i: realIdx}) => {
    const catIdx = allCats.indexOf(link.category || "General");
    const lineColor = catColors[catIdx % catColors.length];
    const faviconUrl = getFavicon(link.url || "");

    const row = linksGrid.createDiv({attr: {
        draggable: "true",
        "data-link-idx": String(realIdx),
        style: `display:flex;align-items:center;gap:12px;padding:9px 12px;background:${isDarkMode ? "rgba(255,255,255,0.025)" : "rgba(0,0,0,0.02)"};border:1px solid ${isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.08)"};border-radius:12px;cursor:pointer;transition:all 0.2s;position:relative;user-select:none;`
    }});

    // Drag handle
    const dragGrip = row.createDiv({attr: {style: `font-size:0.75em;opacity:0.2;cursor:grab;flex-shrink:0;letter-spacing:-1px;transition:opacity 0.15s;color:${isDarkMode?"#fff":"#000"};`}});
    dragGrip.innerText = "⠿";

    // Favicon / emoji icon
    const iconWrap = row.createDiv({attr: {style: `width:28px;height:28px;border-radius:8px;background:${isDarkMode ? "rgba(255,255,255,0.05)" : "rgba(0,0,0,0.05)"};display:flex;align-items:center;justify-content:center;overflow:hidden;flex-shrink:0;`}});
    if (link.emoji) {
        iconWrap.createDiv({attr: {style: "font-size:1em;"}}).innerText = link.emoji;
    } else if (faviconUrl) {
        const img = iconWrap.createEl("img", {attr: {src: faviconUrl, style: "width:16px;height:16px;", alt: ""}});
        img.onerror = () => { iconWrap.innerHTML = ""; iconWrap.createDiv({attr:{style:"font-size:0.85em;opacity:0.4;"}}).innerText="🔗"; };
    } else {
        iconWrap.createDiv({attr: {style: "font-size:0.85em;opacity:0.4;"}}).innerText = "🔗";
    }

    // Title + category dot
    const info = row.createDiv({attr: {style: "flex:1;min-width:0;"}});
    info.createDiv({attr: {style: "font-size:0.82em;font-weight:600;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"}}).innerText = link.title || "Link";
    
    // Category only shown when "All" is selected
    if (!activeCategory) {
        const catRow = info.createDiv({attr: {style: "display:flex;align-items:center;gap:5px;margin-top:2px;"}});
        catRow.createDiv({attr: {style: `width:6px;height:6px;border-radius:50%;background:${lineColor};flex-shrink:0;`}});
        catRow.createDiv({attr: {style: `font-size:0.65em;opacity:0.5;font-weight:600;color:${isDarkMode?"rgba(255,255,255,0.5)":"rgba(0,0,0,0.55)"};`}}).innerText = link.category || "General";
    }

    // Edit btn
    const editBtn = row.createDiv({attr: {style: `font-size:0.65em;opacity:0;padding:3px 8px;border-radius:6px;background:${isDarkMode?"rgba(255,255,255,0.06)":"rgba(0,0,0,0.06)"};cursor:pointer;transition:opacity 0.15s;flex-shrink:0;border:1px solid ${isDarkMode?"rgba(255,255,255,0.08)":"rgba(0,0,0,0.09)"};color:${isDarkMode?"rgba(255,255,255,0.7)":"rgba(0,0,0,0.6)"};`}});
    editBtn.innerText = "✎";
    editBtn.onclick = e => { e.stopPropagation(); openLinkModal(realIdx); };

    row.onmouseenter = () => {
        row.style.background = isDarkMode ? "rgba(255,255,255,0.045)" : "rgba(0,0,0,0.04)";
        row.style.borderColor = `${lineColor}44`;
        row.style.transform = "translateX(2px)";
        editBtn.style.opacity = "1";
        dragGrip.style.opacity = "0.5";
    };
    row.onmouseleave = () => {
        row.style.background = isDarkMode ? "rgba(255,255,255,0.025)" : "rgba(0,0,0,0.02)";
        row.style.borderColor = isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.08)";
        row.style.transform = "";
        editBtn.style.opacity = "0";
        dragGrip.style.opacity = "0.2";
    };

    row.onclick = e => {
        if(e.target===editBtn || editBtn.contains(e.target)) return;
        if(dragSrcIdx !== null) return;
        window.open(link.url, "_blank");
    };

    // -- DRAG EVENTS -------------
    row.ondragstart = e => {
        dragSrcIdx = realIdx;
        row.style.opacity = "0.4";
        e.dataTransfer.effectAllowed = "move";
    };
    row.ondragend = () => { dragSrcIdx = null; dragOverIdx = null; render(); };
    row.ondragover = e => {
        e.preventDefault();
        if(dragSrcIdx===null || dragSrcIdx===realIdx) return;
        if(dragOverIdx !== realIdx){
            dragOverIdx = realIdx;
            linksGrid.querySelectorAll("[data-link-idx]").forEach(el => { el.style.outline=""; });
            row.style.outline = "2px solid rgba(var(--zos-accent-rgb),0.5)";
        }
    };
    row.ondragleave = () => { row.style.outline=""; if(dragOverIdx===realIdx) dragOverIdx=null; };
    row.ondrop = e => {
        e.preventDefault();
        if(dragSrcIdx===null || dragSrcIdx===realIdx) return;
        const moved = linksData.splice(dragSrcIdx, 1)[0];
        const targetPos = linksData.indexOf(link);
        linksData.splice(targetPos>=0 ? targetPos : linksData.length, 0, moved);
        saveLinks();
        dragSrcIdx = null; dragOverIdx = null;
        render();
    };
});
    };

    // -- ADD / EDIT MODAL --------------
    const openLinkModal = (editIdx = -1) => {
        const existing = editIdx >= 0 ? linksData[editIdx] : null;
        const ov = document.body.createDiv({cls: "zos-modal-overlay"});
        const mo = ov.createDiv({cls: "zos-modal", attr: {style: "width:420px;"}});
        const cl = () => ov.remove();
        ov.onclick = e => { if(e.target===ov) cl(); };

        mo.createDiv({cls: "zos-modal-title", text: editIdx >= 0 ? "EDIT LINK" : "ADD LINK"});

        const field = (label, placeholder, value="") => {
            const wrap = mo.createDiv({attr: {style: "margin-bottom:12px;"}});
            wrap.createDiv({attr: {style: `font-size:0.62em;font-weight:700;letter-spacing:1.5px;opacity:${isDarkMode ? "0.35" : "0.55"};margin-bottom:5px;text-transform:uppercase;`}}).innerText = label;
            const inp = wrap.createEl("input", {cls: "zos-modal-input", attr: {type:"text", placeholder, value, style:"margin-bottom:0;"}});
            inp.oninput = () => { inp.style.borderColor=""; };
            inp.onkeydown = e => { if(e.key==="Escape") cl(); };
            return inp;
        };

        const urlInp   = field("URL",      "https://...",             existing?.url      || "");

				// -- AI AUTO-CATEGORIZE BUTTON ---------
		const aiRow = mo.createDiv({attr: {style: "display:flex;align-items:center;justify-content:flex-end;gap:6px;margin-top:-8px;margin-bottom:14px;"}});
		const aiStatus = aiRow.createDiv({attr: {style: "font-size:0.6em;opacity:0.4;font-family:var(--zos-font-mono);"}});
		const aiAutoBtn = aiRow.createEl("button", {attr: {style: "font-size:0.6em;font-weight:700;padding:3px 9px;border-radius:6px;background:transparent;color:rgba(var(--zos-accent-rgb),0.5);border:1px dashed rgba(var(--zos-accent-rgb),0.25);cursor:pointer;transition:all 0.2s;display:flex;align-items:center;gap:4px;letter-spacing:0.3px;"}});
		aiAutoBtn.innerHTML = `✦ auto-fill title, category & emoji`;
		aiAutoBtn.onmouseenter = () => { aiAutoBtn.style.background="rgba(var(--zos-accent-rgb),0.08)"; aiAutoBtn.style.color="var(--zos-accent)"; aiAutoBtn.style.borderColor="rgba(var(--zos-accent-rgb),0.5)"; };
		aiAutoBtn.onmouseleave = () => { aiAutoBtn.style.background="transparent"; aiAutoBtn.style.color="rgba(var(--zos-accent-rgb),0.5)"; aiAutoBtn.style.borderColor="rgba(var(--zos-accent-rgb),0.25)"; };
		
		const titleInp = field("Title",    "e.g. GitHub",             existing?.title    || "");
		const catInp   = field("Category", "e.g. Work, Study, Tools", existing?.category || "General");
		const emojiInp = field("Emoji (optional)", "e.g. 🛠️",        existing?.emoji    || "");

        aiAutoBtn.onclick = async () => {
            const url = urlInp.value.trim();
            if (!url) {
                urlInp.style.borderColor = "#ff5555";
                urlInp.focus();
                return;
            }
            const fullUrl = url.startsWith("http") ? url : "https://"+url;

            aiAutoBtn.style.pointerEvents = "none";
            aiAutoBtn.innerHTML = `<span style="display:inline-flex;gap:3px;align-items:center;"><span style="animation:zos-dot-pulse 1.2s ease-in-out 0s infinite">●</span><span style="animation:zos-dot-pulse 1.2s ease-in-out 0.2s infinite">●</span><span style="animation:zos-dot-pulse 1.2s ease-in-out 0.4s infinite">●</span></span>`;
            aiStatus.innerText = "Analyzing...";

            try {
                // Derive domain info for the AI
                let domain = "";
                try { domain = new URL(fullUrl).hostname.replace("www.",""); } catch(e){}

                // Existing categories for smarter suggestions
                const existingCats = [...new Set(linksData.map(l => l.category||"General"))];

                const data = await guardedAIRequest("links-autofill-"+Date.now(), {
                    max_tokens: 120,
                    messages: [{
                        role: "user",
                        content: [
                            `URL: ${fullUrl}`,
                            `Domain: ${domain}`,
                            existingCats.length ? `My existing categories: ${existingCats.join(", ")}` : "",
                            "",
                            "Return ONLY a JSON object (no markdown, no explanation) with these fields:",
                            '{"title":"short friendly name","category":"best category (reuse existing if it fits)","emoji":"one relevant emoji"}',
                            "Keep title under 20 chars. Pick the most relevant emoji. Reuse an existing category if it fits, otherwise create a short one."
                        ].filter(Boolean).join("\n")
                    }]
                });

                const raw = data?.choices?.[0]?.message?.content?.trim() || "";
                const clean = raw.replace(/```json|```/g,"").trim();
                const parsed = JSON.parse(clean);

                if(parsed.title)    titleInp.value = parsed.title;
                if(parsed.category) catInp.value   = parsed.category;
                if(parsed.emoji)    emojiInp.value  = parsed.emoji;

                aiStatus.innerText = `✓ ${data._provider||"AI"}`;
                aiStatus.style.color = "var(--zos-accent)";
                titleInp.focus();
            } catch(e) {
                const msg = (e?.message||"").toString();
                const gap = parseAIWaitError(msg,"AI_GAP");
                const cd  = parseAIWaitError(msg,"AI_COOLDOWN");
                aiStatus.innerText = cd>0 ? `Retry in ${fmtAIWait(cd)}` : gap>0 ? `Wait ${fmtAIWait(gap)}` : "AI unavailable";
                aiStatus.style.color = "#ff5555";

                // Graceful fallback — derive title from domain
                if(!titleInp.value){
                    try {
                        const domain = new URL(fullUrl).hostname.replace("www.","");
                        titleInp.value = domain.split(".")[0].charAt(0).toUpperCase() + domain.split(".")[0].slice(1);
                    } catch(e2){}
                }
            } finally {
                aiAutoBtn.innerHTML = `<span style="font-size:1.1em;">✦</span> Auto-fill with AI`;
                aiAutoBtn.style.pointerEvents = "";
            }
        };

        titleInp.focus();

        const btnRow = mo.createDiv({cls: "zos-modal-row"});
        btnRow.createEl("button", {cls:"zos-modal-btn zos-btn-cancel", text:"Cancel"}).onclick = cl;
        const saveBtn = btnRow.createEl("button", {cls:"zos-modal-btn zos-btn-save", text: editIdx>=0 ? "Save" : "Add Link"});

        saveBtn.onclick = () => {
            const title = titleInp.value.trim();
            const url   = urlInp.value.trim();
            if (!title) { titleInp.style.borderColor="#ff5555"; titleInp.focus(); return; }
            if (!url)   { urlInp.style.borderColor="#ff5555";   urlInp.focus();   return; }
            const entry = {
                title,
                url: url.startsWith("http") ? url : "https://"+url,
                category: catInp.value.trim() || "General",
                emoji: emojiInp.value.trim()
            };
            if (editIdx >= 0) linksData[editIdx] = entry;
            else linksData.push(entry);
            saveLinks();
            render();
            cl();
        };

        [titleInp, urlInp, catInp, emojiInp].forEach(inp => {
            inp.onkeydown = e => { if(e.key==="Enter") saveBtn.click(); if(e.key==="Escape") cl(); };
        });

        if (editIdx >= 0) {
            mo.createEl("button", {cls:"zos-modal-btn zos-btn-delete", text:"🗑 Delete Link", attr:{style:"width:100%;margin-top:8px;"}})
              .onclick = () => { linksData.splice(editIdx,1); saveLinks(); render(); cl(); };
        }
    };

    addBtn.onclick = () => openLinkModal(-1);
    render();
    return w;
}

// -- MATERIAL VIEWER MODAL -------------
function openMaterialModal(title, url, type, mime=""){
    const ov = document.body.createDiv({cls:"zos-modal-overlay"});
    const matModalBg = isDarkMode ? 'rgba(22,22,30,0.97)' : 'rgba(248,249,250,0.97)';
    const matModalBorder = isDarkMode ? 'rgba(255,255,255,0.08)' : 'rgba(0,0,0,0.08)';
    const bodyBg = isDarkMode ? '#525659' : '#ffffff';
    const mo = ov.createDiv({attr:{style:`width:min(920px,96vw);height:90vh;display:flex;flex-direction:column;padding:0;overflow:hidden;border-radius:16px;background:${matModalBg};border:1px solid ${matModalBorder};box-shadow:0 30px 80px rgba(0,0,0,0.5);flex-shrink:0;`}});
    const cl = () => ov.remove();
    ov.onclick = e => { if(e.target===ov) cl(); };

    // -- HEADER ----------------
    const hdrBorder = isDarkMode ? 'rgba(255,255,255,0.06)' : 'rgba(0,0,0,0.06)';
    const hdrText = isDarkMode ? '#fff' : '#0f0f0f';
    const hdr = mo.createDiv({attr:{style:`display:flex;align-items:center;gap:10px;padding:14px 18px;border-bottom:1px solid ${hdrBorder};flex-shrink:0;color:${hdrText};`}});
    const typeColors={"PDF":"#ff5555","DOCX":"#00aaff","DOC":"#00aaff","PPTX":"#ff8c00","PPT":"#ff8c00","XLSX":"#00ff88","XLS":"#00ff88","VIDEO":"#b450ff","LINK":"#00e5ff","FORM":"#ffc800"};
    const tc = typeColors[type] || "rgba(255,255,255,0.4)";
    hdr.createDiv({attr:{style:`font-size:0.58em;font-weight:800;padding:2px 8px;border-radius:6px;background:${tc}22;color:${tc};flex-shrink:0;`}}).innerText = type||"FILE";
    hdr.createDiv({attr:{style:"flex:1;font-size:0.82em;font-weight:700;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;opacity:0.9;"}}).innerText = title||"Material";

    const openBtn = hdr.createEl("button", {attr:{style:"font-size:0.65em;font-weight:700;padding:4px 10px;border-radius:8px;background:rgba(var(--zos-accent-rgb),0.1);color:var(--zos-accent);border:1px solid rgba(var(--zos-accent-rgb),0.25);cursor:pointer;transition:all 0.2s;white-space:nowrap;flex-shrink:0;"}});
    openBtn.innerText = "↗ Open";
    openBtn.onmouseenter = () => { openBtn.style.background="rgba(var(--zos-accent-rgb),0.2)"; };
    openBtn.onmouseleave = () => { openBtn.style.background="rgba(var(--zos-accent-rgb),0.1)"; };
    openBtn.onclick = () => window.open(url, "_blank");

    const closeBtn = hdr.createEl("button", {attr:{style:`font-size:0.75em;opacity:0.3;cursor:pointer;padding:3px 8px;border-radius:6px;background:transparent;border:none;color:${hdrText};transition:all 0.2s;`}});
    closeBtn.innerText = "✕";
    closeBtn.onmouseenter = () => { closeBtn.style.opacity="1"; closeBtn.style.background="rgba(255,85,85,0.15)"; closeBtn.style.color="#ff5555"; };
    closeBtn.onmouseleave = () => { closeBtn.style.opacity="0.3"; closeBtn.style.background="transparent"; closeBtn.style.color=hdrText; };
    closeBtn.onclick = cl;

    // -- BODY ----------------
    const body = mo.createDiv({attr:{style:`flex:1;overflow:hidden;position:relative;background:${bodyBg};`}});

    // Loading spinner
    const loader = body.createDiv({attr:{style:"position:absolute;inset:0;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:12px;z-index:2;"}});
    loader.createDiv({attr:{style:"width:32px;height:32px;border-radius:50%;border:3px solid rgba(255,255,255,0.06);border-top-color:var(--zos-accent);animation:zos-spin 0.8s linear infinite;"}});
    loader.createDiv({attr:{style:"font-size:0.72em;opacity:0.4;"}}).innerText = "Loading...";

    // Add spin keyframe if not already added
    if(!document.getElementById("zos-spin-style")){
        const s = document.createElement("style");
        s.id = "zos-spin-style";
        s.textContent = "@keyframes zos-spin{to{transform:rotate(360deg)}}";
        document.head.appendChild(s);
    }

    const mime_lc = (mime||"").toLowerCase();
    const isVideo  = type==="VIDEO" || url.includes("youtube") || url.includes("youtu.be");
    const isPDF    = type==="PDF"   || mime_lc.includes("pdf") || url.match(/\.pdf(\?|$)/i);
    const isImage  = mime_lc.includes("image") || /\.(png|jpg|jpeg|gif|webp|svg)(\?|$)/i.test(url);
    const isGDoc   = mime_lc.includes("google-apps.document")   || url.includes("docs.google.com/document");
    const isGSheet = mime_lc.includes("google-apps.spreadsheet")|| url.includes("docs.google.com/spreadsheets");
    const isGSlide = mime_lc.includes("google-apps.presentation")|| url.includes("docs.google.com/presentation");
    const isDocx   = type==="DOCX"  || mime_lc.includes("wordprocessingml");
    const isForm   = type==="FORM"  || url.includes("docs.google.com/forms");

    // Extract Drive file ID
    const getDriveId = (u) => {
        const m = u.match(/\/(?:file\/d|document\/d|spreadsheets\/d|presentation\/d)\/([a-zA-Z0-9_-]+)/);
        return m ? m[1] : "";
    };

    let tok = "";
    const driveId = getDriveId(url);

    const showFallback = (reason="") => {
        loader.remove();
        body.innerHTML = "";
        const fb = body.createDiv({attr:{style:"display:flex;flex-direction:column;align-items:center;justify-content:center;height:100%;gap:14px;padding:40px;text-align:center;"}});
        fb.createDiv({attr:{style:"font-size:3em;opacity:0.25;"}}).innerText = isPDF?"📄":isVideo?"🎬":isDocx?"📝":"📎";
        fb.createDiv({attr:{style:"font-size:0.88em;font-weight:700;opacity:0.65;max-width:340px;"}}).innerText = title||"Material";
        if(reason) fb.createDiv({attr:{style:"font-size:0.68em;opacity:0.3;max-width:320px;line-height:1.5;margin-top:4px;"}}).innerText = reason;
        fb.createDiv({attr:{style:"font-size:0.72em;opacity:0.3;max-width:320px;line-height:1.5;"}}).innerText = "Can't preview this file here — open it in your student Chrome profile.";
        const fb_btn = fb.createEl("button", {attr:{style:"font-size:0.78em;font-weight:700;padding:9px 20px;border-radius:10px;background:rgba(var(--zos-accent-rgb),0.12);color:var(--zos-accent);border:1px solid rgba(var(--zos-accent-rgb),0.25);cursor:pointer;margin-top:6px;"}});
        fb_btn.innerText = "↗ Open in Browser";
        fb_btn.onclick = () => window.open(url, "_blank");
    };

    // -- TOKEN-BASED FETCH RENDERER ---------
    const renderWithToken = async () => {
        tok = await getWorkspaceAccessToken();
        if(!tok){ showFallback("No access token found. Make sure Google Workspace is connected."); return; }

        // -- STEP 1: Try to get a Classroom-authorized download URL --
        // Extract course + coursework + submission IDs from the material URL
        const getClassroomDownloadUrl = async () => {
            // The material URL looks like:
            // https://classroom.google.com/c/{courseId}/a/{workId} or similar
            // But the driveId is what we have — ask Classroom for student submissions
            // to get an authorized temp URL for the file
            if(!driveId) return null;
            try {
                // Try Drive API first with a different endpoint — files.get with acknowledgeAbuse
                const metaRes = await fetch(
                    `https://www.googleapis.com/drive/v3/files/${driveId}?fields=id,name,mimeType,webContentLink,webViewLink,exportLinks`,
                    {headers:{"Authorization":`Bearer ${tok}`}}
                );
                if(metaRes.ok){
                    const meta = await metaRes.json();
                    // Use exportLinks if available (Google native formats)
                    if(meta.exportLinks){
                        const htmlExport = meta.exportLinks["text/html"] || meta.exportLinks["application/pdf"];
                        if(htmlExport) return {url: htmlExport, type:"export"};
                    }
                    // Use webContentLink for binary files
                    if(meta.webContentLink) return {url: meta.webContentLink, type:"download"};
                    // Use webViewLink as last resort
                    if(meta.webViewLink) return {url: meta.webViewLink, type:"view"};
                }
            } catch(e){}
            return null;
        };

        try {
            if(isVideo){
                loader.remove(); body.innerHTML="";
                let embedUrl = url;
                const ytMatch = url.match(/(?:youtu\.be\/|youtube\.com\/(?:watch\?v=|embed\/))([a-zA-Z0-9_-]{11})/);
                if(ytMatch) embedUrl = `https://www.youtube.com/embed/${ytMatch[1]}?rel=0`;
                body.createEl("iframe",{attr:{src:embedUrl,style:"width:100%;height:100%;border:none;",allowfullscreen:"true",allow:"accelerometer;autoplay;clipboard-write;encrypted-media;gyroscope;picture-in-picture"}});
                return;
            }

            if(isForm){
                loader.remove(); body.innerHTML="";
                body.createEl("iframe",{attr:{src:url,style:"width:100%;height:100%;border:none;"}});
                return;
            }

            if(isImage && !driveId){
                loader.remove(); body.innerHTML="";
                const imgWrap = body.createDiv({attr:{style:"width:100%;height:100%;display:flex;align-items:center;justify-content:center;padding:20px;box-sizing:border-box;"}});
                imgWrap.createEl("img",{attr:{src:url,style:"max-width:100%;max-height:100%;object-fit:contain;border-radius:8px;"}});
                return;
            }

            // -- Try Classroom API to get file metadata -----
            // Use Drive files.get to check what we can access
            const metaRes = await fetch(
                `https://www.googleapis.com/drive/v3/files/${driveId}?fields=id,name,mimeType,webViewLink,exportLinks,thumbnailLink`,
                {headers:{"Authorization":`Bearer ${tok}`}}
            );

            if(!metaRes.ok){
                // 403 — token lacks Drive scope
                // Fall back to rendering via Google Docs Viewer with the webViewLink
                // using a special Classroom viewer URL that respects the session
                showFallback(`Access denied (HTTP ${metaRes.status}). Your Google token doesn't have Drive read scope. Re-authorize with Drive scope for inline preview, or open in browser.`);
                // Override fallback open button to use Classroom direct URL
                const btns = body.querySelectorAll("button");
                if(btns.length) btns[0].onclick = () => window.open(url, "_blank");
                return;
            }

            const meta = await metaRes.json();
            const fileMime = meta.mimeType || mime;
            loader.remove(); body.innerHTML="";

            // -- Google native formats — export as HTML -----
            if(fileMime.includes("google-apps.document") || fileMime.includes("google-apps.spreadsheet")){
                const exportRes = await fetch(
                    `https://www.googleapis.com/drive/v3/files/${driveId}/export?mimeType=text/html`,
                    {headers:{"Authorization":`Bearer ${tok}`}}
                );
                if(!exportRes.ok) throw new Error(`Export failed: HTTP ${exportRes.status}`);
                const html = await exportRes.text();
                const docBg = isDarkMode ? '#1a1a1a' : '#fff';
                const docText = isDarkMode ? '#fff' : '#111';
                const scrollArea = body.createDiv({attr:{style:`width:100%;height:100%;overflow-y:auto;padding:28px 36px;box-sizing:border-box;background:${docBg};color:${docText};font-family:Georgia,serif;font-size:0.93em;line-height:1.7;`}});
                scrollArea.innerHTML = html;
                return;
            }

            if(fileMime.includes("google-apps.presentation")){
                const exportRes = await fetch(
                    `https://www.googleapis.com/drive/v3/files/${driveId}/export?mimeType=application/pdf`,
                    {headers:{"Authorization":`Bearer ${tok}`}}
                );
                if(!exportRes.ok) throw new Error(`Export failed: HTTP ${exportRes.status}`);
                const ab = await exportRes.arrayBuffer();
                await renderPDFBuffer(ab);
                return;
            }

            // -- Binary files — fetch with token --------
            const fileRes = await fetch(
                `https://www.googleapis.com/drive/v3/files/${driveId}?alt=media`,
                {headers:{"Authorization":`Bearer ${tok}`}}
            );
            if(!fileRes.ok) throw new Error(`HTTP ${fileRes.status}`);

            if(isPDF || fileMime.includes("pdf")){
                const ab = await fileRes.arrayBuffer();
                await renderPDFBuffer(ab);

            } else if(isDocx || fileMime.includes("wordprocessingml")){
                const ab = await fileRes.arrayBuffer();
                await loadExternalScriptOnce("https://unpkg.com/mammoth@1.8.0/mammoth.browser.min.js","mammoth");
                const result = await window.mammoth.convertToHtml({arrayBuffer:ab});
                const docxBg = isDarkMode ? '#1a1a1a' : '#fff';
                const docxText = isDarkMode ? '#fff' : '#111';
                const scrollArea = body.createDiv({attr:{style:`width:100%;height:100%;overflow-y:auto;padding:28px 36px;box-sizing:border-box;background:${docxBg};color:${docxText};font-family:Georgia,serif;font-size:0.95em;line-height:1.7;`}});
                scrollArea.innerHTML = result.value || "<p>No content.</p>";

            } else if(isImage || fileMime.includes("image")){
                const blob = await fileRes.blob();
                const blobUrl = URL.createObjectURL(blob);
                const imgWrap = body.createDiv({attr:{style:"width:100%;height:100%;display:flex;align-items:center;justify-content:center;padding:20px;box-sizing:border-box;"}});
                imgWrap.createEl("img",{attr:{src:blobUrl,style:"max-width:100%;max-height:100%;object-fit:contain;border-radius:8px;"}});

            } else {
                showFallback("Preview not available for this file type.");
            }

        } catch(e){
            showFallback("Could not load: " + (e.message||"unknown error").slice(0,100));
        }
    };

    // -- PDF RENDERER HELPER ------------
    const renderPDFBuffer = async (arrayBuffer) => {
    try {
        // 1) Prefer native PDF rendering first (works without external scripts).
        const renderNativePdf = () => {
            const blob = new Blob([arrayBuffer], { type: "application/pdf" });
            const blobUrl = URL.createObjectURL(blob);
            body.innerHTML = "";
            const pdfIframeBg = isDarkMode ? '#1a1a1a' : '#ffffff';

            const frame = body.createEl("iframe", {
                attr: {
                    src: blobUrl,
                    style: `width:100%;height:100%;border:none;background:${pdfIframeBg};`,
                    },
                });

                frame.onload = () => {
                    // Keep URL alive while modal is open.
                };
            frame.onerror = () => {
                URL.revokeObjectURL(blobUrl);
                throw new Error("Native PDF viewer failed");
            };

            // Revoke on modal close/removal to avoid leaks.
            const cleanup = () => URL.revokeObjectURL(blobUrl);
            ov.addEventListener("remove", cleanup, { once: true });
        };

        try {
            renderNativePdf();
            return;
        } catch (nativeErr) {
            // Fall through to pdf.js renderer.
        }

        // 2) Fallback to pdf.js renderer from CDN.
        // Try multiple CDN sources
const pdfjsSrcs = [
    "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/4.6.82/pdf.min.js",
    "https://unpkg.com/pdfjs-dist@4.6.82/legacy/build/pdf.min.js",
    "https://cdn.jsdelivr.net/npm/pdfjs-dist@4.6.82/legacy/build/pdf.min.js"
];
let pdfjsLoaded = false;
for(const src of pdfjsSrcs){
    try{ await loadExternalScriptOnce(src,"pdfjsLib"); pdfjsLoaded=true; break; }catch(e){ continue; }
}
if(!pdfjsLoaded) throw new Error("Could not load PDF renderer — check Obsidian network settings allow external scripts.");
        const pdfjs = window.pdfjsLib;
        if(!pdfjs) throw new Error("pdfjs unavailable");

        const pdf = await pdfjs.getDocument({data:arrayBuffer,disableWorker:true,isEvalSupported:false}).promise;
        body.innerHTML = "";

        const pdfScrollBg = isDarkMode ? '#1a1a1a' : '#f5f5f5';
        const scrollArea = body.createDiv({attr:{style:`width:100%;height:100%;overflow-y:auto;overflow-x:hidden;padding:20px 24px;box-sizing:border-box;display:flex;flex-direction:column;align-items:center;gap:16px;background:${pdfScrollBg};`}});

        // Page count badge
        const badge = body.createDiv({attr:{style:"position:absolute;top:8px;right:14px;font-size:0.6em;font-family:var(--zos-font-mono);opacity:0.3;z-index:3;pointer-events:none;background:rgba(0,0,0,0.5);padding:2px 7px;border-radius:6px;"}});
        badge.innerText = `${pdf.numPages} pages`;

        // Get container width to calculate scale
        const containerWidth = body.getBoundingClientRect().width || 800;

        for(let i = 1; i <= pdf.numPages; i++){
            const page = await pdf.getPage(i);

            // Calculate scale to fit container width
            const unscaledVp = page.getViewport({scale:1});
            const scale = (containerWidth - 80) / unscaledVp.width;
            const viewport = page.getViewport({scale: Math.min(scale, 2.0)});

            // Create canvas with exact pixel dimensions — do NOT use CSS width/height
            const canvas = document.createElement("canvas");
            canvas.width  = viewport.width;
            canvas.height = viewport.height;
            canvas.style.cssText = `display:block;border-radius:8px;box-shadow:0 4px 20px rgba(0,0,0,0.5);max-width:100%;`;

            scrollArea.appendChild(canvas);

            const ctx = canvas.getContext("2d");
            await page.render({canvasContext: ctx, viewport}).promise;
        }
    } catch(e){
        body.innerHTML = "";
        const fb = body.createDiv({attr:{style:"display:flex;flex-direction:column;align-items:center;justify-content:center;height:100%;gap:12px;padding:40px;text-align:center;"}});
        fb.createDiv({attr:{style:"font-size:2.5em;opacity:0.3;"}}).innerText = "📄";
        fb.createDiv({attr:{style:"font-size:0.85em;font-weight:700;opacity:0.5;"}}).innerText = "Could not render PDF inline.";
        fb.createDiv({attr:{style:"font-size:0.7em;opacity:0.3;"}}).innerText = e.message||"";
        const btn = fb.createEl("button",{attr:{style:"font-size:0.78em;font-weight:700;padding:9px 20px;border-radius:10px;background:rgba(var(--zos-accent-rgb),0.12);color:var(--zos-accent);border:1px solid rgba(var(--zos-accent-rgb),0.25);cursor:pointer;margin-top:8px;"}});
        btn.innerText = "↗ Open in Browser";
        btn.onclick = () => window.open(url, "_blank");
    }
};

    renderWithToken();
}

// -- SETUP WIZARD ----------------
const ZOS_LEGACY_OAUTH_WORKER_URL = "https://zenos-auth.rubasali-paf.workers.dev";

// -- LEFT DRAG -----------------
const cardBuilders={clock:buildClockCard,system:buildSystemCard,links:buildLinksCard,github:buildGitHubCard};

function renderLeftCol(){
    leftCol.innerHTML="";
    leftOrder.forEach(id=>{if(cardBuilders[id])leftCol.appendChild(cardBuilders[id]());});
    initLeftDrag();
}

function initLeftDrag(){
    const getCards=()=>[...leftCol.querySelectorAll(".zos-left-card")];
    getCards().forEach(card=>{
        const handle=card.querySelector("[data-drag-handle]");
        if(!handle)return;
        handle.onmousedown=e=>{
            if(e.target.closest("input,button,.zos-settings-btn,[contenteditable]"))return;
            e.preventDefault();
            const sx=e.clientX,sy=e.clientY;
            let dragStarted=false,ghost=null,dragOverCard=null;
            const onMove=ev=>{
                if(!dragStarted){if(Math.hypot(ev.clientX-sx,ev.clientY-sy)<8)return;dragStarted=true;const rect=card.getBoundingClientRect();ghost=card.cloneNode(true);ghost.style.cssText=`position:fixed;left:${rect.left}px;top:${rect.top}px;width:${rect.width}px;z-index:9999;pointer-events:none;opacity:0.55;transform:rotate(1.2deg) scale(1.02);box-shadow:0 28px 70px rgba(0,0,0,0.65);border-radius:28px;transition:none;`;document.body.appendChild(ghost);card.style.opacity="0.12";card.style.transition="none";document.body.style.userSelect="none";document.body.style.cursor="grabbing";}
                if(!ghost)return;
                ghost.style.left=`${ev.clientX-(card.getBoundingClientRect().width/2)}px`;ghost.style.top=`${ev.clientY-40}px`;
                let nearest=null,nearestDist=Infinity;
                getCards().forEach(c=>{if(c===card)return;const r=c.getBoundingClientRect();const dist=Math.abs(ev.clientY-(r.top+r.height/2));if(dist<nearestDist){nearestDist=dist;nearest=c;}});
                getCards().forEach(c=>{if(c!==card){c.style.outline="";c.style.outlineOffset="";c.style.transform="";}});
                if(nearest&&nearestDist<nearest.getBoundingClientRect().height){nearest.style.outline="2px solid rgba(var(--zos-accent-rgb),0.5)";nearest.style.outlineOffset="4px";const nr=nearest.getBoundingClientRect();nearest.style.transform=ev.clientY<nr.top+nr.height/2?"translateY(6px)":"translateY(-6px)";dragOverCard=nearest;}else{dragOverCard=null;}
            };
            const onUp=()=>{
                document.removeEventListener("mousemove",onMove);document.removeEventListener("mouseup",onUp);
                if(ghost){ghost.remove();ghost=null;}
                getCards().forEach(c=>{c.style.opacity="";c.style.transition="";c.style.outline="";c.style.outlineOffset="";c.style.transform="";});
                document.body.style.userSelect="";document.body.style.cursor="";
                if(!dragStarted)return;
                if(dragOverCard){const dragId=card.getAttribute("data-card-id"),overId=dragOverCard.getAttribute("data-card-id");const di=leftOrder.indexOf(dragId),ti=leftOrder.indexOf(overId);if(di!==-1&&ti!==-1&&di!==ti){leftOrder.splice(di,1);leftOrder.splice(ti,0,dragId);save("zos-left-order",leftOrder);const ordered=leftOrder.map(id=>getCards().find(c=>c.getAttribute("data-card-id")===id)).filter(Boolean);ordered.forEach(c=>leftCol.appendChild(c));initLeftDrag();}}
            };
            document.addEventListener("mousemove",onMove);document.addEventListener("mouseup",onUp);
        };
    });
}

// -- RIGHT DRAG ----------------
const rightBuilders={pipeline:buildPipelineCard,ainews:buildAINewsCard};
let rightHeightSyncRaf=null;

function syncRightCardHeights(){
    if(!rightCol)return;
}

function scheduleRightHeightSync(){
    if(rightHeightSyncRaf!==null) cancelAnimationFrame(rightHeightSyncRaf);
    rightHeightSyncRaf=requestAnimationFrame(()=>{
        rightHeightSyncRaf=null;
        syncRightCardHeights();
    });
}

function renderRightCol(){
    stopTimers();
    rightCol.innerHTML="";
    rightOrder.forEach(id=>{if(rightBuilders[id])rightCol.appendChild(rightBuilders[id]());});

    initRightDrag();
    scheduleRightHeightSync();
}

function initRightDrag(){
    const getCards=()=>[...rightCol.querySelectorAll("[data-right-id]")];
    getCards().forEach(card=>{
        const handle=card.querySelector("[data-right-drag]");
        if(!handle)return;
        handle.onmousedown=e=>{
            if(e.target.closest("input,button,.zos-settings-btn"))return;
            e.preventDefault();
            const sx=e.clientX,sy=e.clientY;
            let dragStarted=false,ghost=null,dragOverCard=null;
            const onMove=ev=>{
                if(!dragStarted){if(Math.hypot(ev.clientX-sx,ev.clientY-sy)<8)return;dragStarted=true;const rect=card.getBoundingClientRect();ghost=card.cloneNode(true);ghost.style.cssText=`position:fixed;left:${rect.left}px;top:${rect.top}px;width:${rect.width}px;z-index:9999;pointer-events:none;opacity:0.5;transform:rotate(0.5deg) scale(1.01);box-shadow:0 24px 60px rgba(0,0,0,0.6);border-radius:28px;transition:none;`;document.body.appendChild(ghost);card.style.opacity="0.15";card.style.transition="none";document.body.style.userSelect="none";document.body.style.cursor="grabbing";}
                if(!ghost)return;
                ghost.style.left=`${ev.clientX-(card.getBoundingClientRect().width/2)}px`;ghost.style.top=`${ev.clientY-40}px`;
                let nearest=null,nearestDist=Infinity;
                getCards().forEach(c=>{if(c===card)return;const r=c.getBoundingClientRect();const dist=Math.abs(ev.clientY-(r.top+r.height/2));if(dist<nearestDist){nearestDist=dist;nearest=c;}});
                getCards().forEach(c=>{if(c!==card){c.style.outline="";c.style.transform="";}});
                if(nearest){nearest.style.outline="2px solid rgba(var(--zos-accent-rgb),0.5)";const nr=nearest.getBoundingClientRect();nearest.style.transform=ev.clientY<nr.top+nr.height/2?"translateY(6px)":"translateY(-6px)";dragOverCard=nearest;}else{dragOverCard=null;}
            };
            const onUp=()=>{
                document.removeEventListener("mousemove",onMove);document.removeEventListener("mouseup",onUp);
                if(ghost){ghost.remove();ghost=null;}
                getCards().forEach(c=>{c.style.opacity="";c.style.transition="";c.style.outline="";c.style.transform="";});
                document.body.style.userSelect="";document.body.style.cursor="";
                if(!dragStarted)return;
                if(dragOverCard){const dragId=card.getAttribute("data-right-id"),overId=dragOverCard.getAttribute("data-right-id");const di=rightOrder.indexOf(dragId),ti=rightOrder.indexOf(overId);if(di!==-1&&ti!==-1&&di!==ti){rightOrder.splice(di,1);rightOrder.splice(ti,0,dragId);save("zos-right-order",rightOrder);const ordered=rightOrder.map(id=>getCards().find(c=>c.getAttribute("data-right-id")===id)).filter(Boolean);ordered.forEach(c=>rightCol.appendChild(c));initRightDrag();scheduleRightHeightSync();}}
            };
            document.addEventListener("mousemove",onMove);document.addEventListener("mouseup",onUp);
        };
    });
}

// -- FETCH -----------------------------
async function fetchAndRender(){
    if(!listCont||!summaryBar||!gcalBadge)return;
    listCont.innerHTML="";summaryBar.innerHTML="";
    listCont.createDiv({attr:{style:"text-align:center;padding:24px;opacity:0.4;font-size:0.8em;"}}).innerText="Fetching assignments...";
    stopTimers();
    try{
        const gw=window.googleWorkspace;
        if(!gw) throw new Error("Google Workspace plugin not found.");
        if(!gw.isConnected()) throw new Error("Not connected — open Google Workspace settings.");
        const calSources=[];
        if(gw.getCourses){
            const courses=await gw.getCourses();
            calSources.push(...(courses||[]).map(c=>({id:c.id,summary:c.name||c.id})));
        }
        if(gw.getCalendars){
            const cals=await gw.getCalendars();
            (cals||[]).forEach(c=>{
                if(!calSources.some(s=>s.id===c.id)) calSources.push({id:c.id,summary:c.name||c.summary||c.id});
            });
        }
        allCalendars=calSources;
        const startDate=window.moment().subtract(60,"days").toDate();
        const endDate=window.moment().add(120,"days").toDate();
        const calEvents=gw.getEvents?await gw.getEvents(startDate,endDate):[];
        const assignments=await gw.getAssignments();
        allEvents=[...(assignments||[]),...(calEvents||[]).map(e=>({
            title:e.title||"Untitled",
            description:e.description||"",
            dueDate:e.start instanceof Date?e.start:(e.start?new Date(e.start):null),
            htmlLink:e.htmlLink||"",
            id:e.id,
            courseId:e.calendarId||"calendar",
            courseName:e.calendarName||"Calendar",
            materials:[],
        }))]
        allEvents=(allEvents)
            .map(a=>{
                const dueDate = a.dueDate instanceof Date
                    ? a.dueDate
                    : (a.dueDate ? new Date(a.dueDate) : null);
                const dueIso = dueDate && !Number.isNaN(dueDate.getTime())
                    ? dueDate.toISOString()
                    : null;
                return {
                    id:`${a.courseId||"course"}-${a.id}`,
                    summary:a.title||"Untitled",
                    description:a.description||"",
                    htmlLink:a.htmlLink||"",
                    start:{dateTime:dueIso},
                    end:{dateTime:dueIso},
                    parent:{summary:a.courseName||"General",id:a.courseId||"general"},
                    materials:a.materials||[],
                };
            })
            .filter(ev=>{
                const d=getEventDate(ev);
                if(selectedCals.length>0&&!selectedCals.includes(getCalName(ev))) return false;
                if(!d) return true;
                return d>=startDate&&d<=endDate;
            });
        if(!Array.isArray(allEvents)) throw new Error("Unexpected response.");
        lastSynced=new Date();
        if(lastSyncEl) lastSyncEl.innerText=`Last synced: ${lastSynced.toLocaleTimeString("en-US",{hour:"2-digit",minute:"2-digit"})}`;
        renderHeaderStats();renderSummaryBar();switchView();scheduleRightHeightSync();
    }catch(err){
        listCont.innerHTML="";
        const errBox = listCont.createDiv({ attr:{ style:`
            text-align:center;padding:36px 24px;
            background:rgba(255,140,0,0.05);border:1px dashed rgba(255,140,0,0.2);
            border-radius:16px;
        `}});
        errBox.createDiv({ attr:{ style:"font-size:1.8em;margin-bottom:10px;" }}).innerText = "📅";
        errBox.createDiv({ attr:{ style:"font-size:0.88em;font-weight:700;opacity:0.75;margin-bottom:8px;" }})
            .innerText = "Google Workspace not connected yet";
        errBox.createDiv({ attr:{ style:"font-size:0.75em;opacity:0.45;line-height:1.7;max-width:320px;margin:0 auto;" }})
            .innerText = "Enable the Google Workspace plugin, connect your Google account in its settings, then click the refresh button (↺) at the top right.";
    }
}

// -- SUMMARY BAR -----------------
function renderSummaryBar(){
    if(!summaryBar)return;
    summaryBar.innerHTML="";
    const now=new Date(),tS=new Date(now);tS.setHours(0,0,0,0);
    const tE=new Date(tS);tE.setHours(23,59,59,999);
    const wE=new Date(tS.getTime()+7*86400000);
    const pending=allEvents.filter(ev=>!isDone(ev));
    const ov=pending.filter(ev=>{const d=getEventDate(ev);return d&&d<tS;}).length;
    const td=pending.filter(ev=>{const d=getEventDate(ev);return d&&d>=tS&&d<=tE;}).length;
    const wk=pending.filter(ev=>{const d=getEventDate(ev);return d&&d>tE&&d<=wE;}).length;
    const dn=allEvents.filter(ev=>isDone(ev)).length;
    const hp=pending.filter(ev=>getPrio(ev)==="HIGH").length;
    if(gcalBadge) gcalBadge.innerText=selectedCals.length>0?`${selectedCals.length} COURSE${selectedCals.length>1?"S":""}`:"ALL COURSES";
    [{l:`${ov} Overdue`,c:"#ff5555",bg:"rgba(255,85,85,0.1)",filter:"overdue"},{l:`${td} Today`,c:"#ff8c00",bg:"rgba(255,140,0,0.1)",filter:"today"},{l:`${wk} This Week`,c:"#ffc800",bg:"rgba(255,200,0,0.08)",filter:"week"},{l:`${dn} Done`,c:"#00ff88",bg:"rgba(0,255,136,0.08)",filter:"done"},...(hp>0?[{l:`${hp} High Prio`,c:"#b450ff",bg:"rgba(180,80,255,0.1)",filter:"high"}]:[])].forEach(p=>{
        const pill=summaryBar.createDiv({attr:{style:`font-size:0.65em;font-weight:700;padding:3px 9px;border-radius:20px;white-space:nowrap;color:${p.c};background:${p.bg};letter-spacing:0.4px;cursor:pointer;transition:all 0.2s;border:2px solid ${activeFilter===p.filter?p.c:"transparent"};`}});
        pill.innerText=p.l;pill.setAttribute("data-filter",p.filter);
        pill.onclick=()=>{activeFilter=activeFilter===p.filter?null:p.filter;if(activeFilter)localStorage.setItem("zos-active-filter",activeFilter);else localStorage.removeItem("zos-active-filter");renderSummaryBar();switchView();};
        pill.onmouseenter=()=>{pill.style.opacity="0.8";};pill.onmouseleave=()=>{pill.style.opacity="1";};
    });
    const total=dn+pending.length;
}

// -- LIST VIEW -----------------
function getFilteredEvents(includeDone){
    return allEvents.filter(ev=>{
        if(!includeDone&&isDone(ev))return false;if(includeDone&&!isDone(ev))return false;
        return true;
    });
}

function renderListView(){
    if(!listCont)return;
    listCont.innerHTML="";
    const now=new Date(),tS=new Date(now);tS.setHours(0,0,0,0);
    const tE=new Date(tS);tE.setHours(23,59,59,999);
    const wE=new Date(tS.getTime()+7*86400000);
    if(activeFilter==="done"){
        const doneEvs=getFilteredEvents(true).sort((a,b)=>(getEventDate(b)||new Date(0))-(getEventDate(a)||new Date(0)));
        if(!doneEvs.length){listCont.createDiv({attr:{style:"text-align:center;padding:48px 20px;font-weight:700;opacity:0.5;"}}).innerText="Nothing marked as done yet.";return;}
        renderGroupHeader(listCont,"✓ DONE","#00ff88",doneEvs.length);doneEvs.forEach(ev=>renderEventCard(listCont,ev,true));return;
    }
    let pending=getFilteredEvents(false);
    if(sortMode==="date")pending.sort((a,b)=>(getEventDate(a)||new Date(0))-(getEventDate(b)||new Date(0)));
    else if(sortMode==="course")pending.sort((a,b)=>getCalName(a).localeCompare(getCalName(b)));
    if(pending.length===0){
        const empty=listCont.createDiv({attr:{style:"text-align:center;padding:48px 20px;"}});
        empty.createDiv({attr:{style:"font-size:2em;margin-bottom:10px;"}}).innerText="!";
        empty.createDiv({attr:{style:"font-weight:700;opacity:0.5;"}}).innerText="All caught up!";return;
    }
    if(sortMode==="date"){
        const groups={overdue:{label:"OVERDUE",color:"#ff5555",evs:[]},today:{label:"DUE TODAY",color:"#ff8c00",evs:[]},week:{label:"THIS WEEK",color:"#ffc800",evs:[]},later:{label:"COMING UP",color:"var(--zos-accent)",evs:[]}};
        pending.forEach(ev=>{const d=getEventDate(ev);if(!d||d>wE)groups.later.evs.push(ev);else if(d<tS)groups.overdue.evs.push(ev);else if(d<=tE)groups.today.evs.push(ev);else groups.week.evs.push(ev);});
        
        let foundAny = false;
        ["overdue","today","week","later"].forEach(k=>{
            if(activeFilter&&activeFilter!==k&&activeFilter!=="high")return;
            const g=groups[k];
            if(activeFilter==="high"){
                g.evs = g.evs.filter(ev=>getPrio(ev)==="HIGH");
            }
            if(!g.evs.length)return;
            foundAny = true;
            renderGroupHeader(listCont,g.label,g.color,g.evs.length);g.evs.forEach(ev=>renderEventCard(listCont,ev,false));
        });
        if(activeFilter && !foundAny){
            const empty=listCont.createDiv({attr:{style:"text-align:center;padding:48px 20px;opacity:0.5;font-size:0.9em;display:flex;flex-direction:column;align-items:center;"}});
            empty.createDiv({attr:{style:"font-size:2em;margin-bottom:10px;"}}).innerText="🍃";
            empty.createDiv({attr:{style:"font-weight:700;"}}).innerText="Nothing here at the moment.";
        }
    }else{
        const cg={};pending.forEach(ev=>{const c=getCalName(ev);if(!cg[c])cg[c]=[];cg[c].push(ev);});
        Object.keys(cg).sort().forEach(c=>{renderGroupHeader(listCont,c,"var(--zos-accent)",cg[c].length);cg[c].forEach(ev=>renderEventCard(listCont,ev,false));});
    }
}

function renderGroupHeader(parent,label,color,count){
    const hdr=parent.createDiv({attr:{style:`display:flex;align-items:center;gap:8px;margin:18px 0 8px;padding-bottom:7px;border-bottom:1px solid ${isDarkMode?"rgba(255,255,255,0.05)":"rgba(0,0,0,0.07)"};`}});
    hdr.createDiv({attr:{style:`width:3px;height:14px;border-radius:2px;background:${color};flex-shrink:0;`}});
    hdr.createDiv({text:label,attr:{style:`font-size:0.7em;font-weight:800;letter-spacing:2px;color:${color};`}});
    hdr.createDiv({text:count,attr:{style:`font-size:0.65em;font-weight:700;padding:2px 7px;border-radius:10px;background:${color}22;color:${color};margin-left:auto;`}});
}

const ZOS_EXT_SCRIPT_CACHE={};
async function loadExternalScriptOnce(src,globalName){
    if(globalName&&window[globalName])return true;
    if(ZOS_EXT_SCRIPT_CACHE[src])return ZOS_EXT_SCRIPT_CACHE[src];
    ZOS_EXT_SCRIPT_CACHE[src]=new Promise((resolve,reject)=>{
        const s=document.createElement("script");
        s.src=src;
        s.async=true;
        s.onload=()=>resolve(true);
        s.onerror=()=>reject(new Error(`script load failed: ${src}`));
        document.head.appendChild(s);
    });
    return ZOS_EXT_SCRIPT_CACHE[src];
}

function decodePdfEscapedString(s){
    return s
        .replace(/\\([\\()])/g,"$1")
        .replace(/\\n/g,"\n")
        .replace(/\\r/g,"\r")
        .replace(/\\t/g,"\t")
        .replace(/\\b/g,"\b")
        .replace(/\\f/g,"\f")
        .replace(/\\([0-7]{1,3})/g,(_,oct)=>String.fromCharCode(parseInt(oct,8)));
}

function extractPdfTextFallback(arrayBuffer){
    let raw="";
    try{raw=new TextDecoder("latin1").decode(new Uint8Array(arrayBuffer));}catch(e){return "";}
    const chunks=[];
    const pushIfUseful=t=>{
        const clean=(t||"").replace(/\s+/g," ").trim();
        if(clean&&clean.length>=4)chunks.push(clean);
    };

    const tj=/\(([^\)]{1,800})\)\s*Tj/g;
    let m;
    while((m=tj.exec(raw))!==null){
        pushIfUseful(decodePdfEscapedString(m[1]));
        if(chunks.length>400)break;
    }

    const tjArray=/\[(.*?)\]\s*TJ/gs;
    while((m=tjArray.exec(raw))!==null){
        const seg=m[1];
        const parts=[];
        const lit=/\(([^\)]{1,400})\)/g;
        let p;
        while((p=lit.exec(seg))!==null){
            const v=decodePdfEscapedString(p[1]).trim();
            if(v)parts.push(v);
            if(parts.length>40)break;
        }
        if(parts.length)pushIfUseful(parts.join(" "));
        if(chunks.length>600)break;
    }

    return chunks.join("\n").slice(0,4000).trim();
}



async function getValidDriveToken(){
    const gwTok = await getWorkspaceAccessToken();
    if(gwTok) return gwTok;

    const tok=localStorage.getItem("googleDriveAccessToken")||"";
    const expiry=Number(localStorage.getItem("googleDriveTokenExpiry")||"0");
    if(tok&&Date.now()<expiry-60000)return tok;
    const refreshToken=localStorage.getItem("googleDriveRefreshToken")||"";
    const clientId=localStorage.getItem("googleDriveClientId")||"";
    const clientSecret=localStorage.getItem("googleDriveClientSecret")||"";
    if(!refreshToken||!clientId||!clientSecret){
        return localStorage.getItem("googleDriveAccessToken")||localStorage.getItem("googleCalendarAccessToken")||"";
    }
    try{
        const workerUrl = ZOS_LEGACY_OAUTH_WORKER_URL;
if(!workerUrl) throw new Error("No worker URL configured");
const r = await fetch(`${workerUrl}/refresh`, {
    method:  "POST",
    headers: { "Content-Type": "application/json" },
    body:    JSON.stringify({ refresh_token: refreshToken }),
});
        const data=await r.json();
        if(data.access_token){
            localStorage.setItem("googleDriveAccessToken",data.access_token);
            localStorage.setItem("googleDriveTokenExpiry",String(Date.now()+(data.expires_in||3600)*1000));
            console.log("ZOS: Drive token auto-refreshed ✓");
            return data.access_token;
        }
    }catch(e){console.warn("ZOS: Token refresh failed:",e);}
    return tok||localStorage.getItem("googleCalendarAccessToken")||"";
}
async function extractPdfTextWithOCR(arrayBuffer){
    const tok=(await getValidDriveToken()).trim();
    if(!tok)throw new Error("No token for OCR");
    try{
        const pdfBlob=new Blob([arrayBuffer],{type:"application/pdf"});
        const formData=new FormData();
        formData.append("metadata",new Blob([JSON.stringify({
            name:"ocr_temp_"+Date.now(),
            mimeType:"application/vnd.google-apps.document"
        })],{type:"application/json"}));
        formData.append("file",pdfBlob);
        const authHeader="Bearer "+tok;
        const uploadR=await fetch(
            "https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart&ocr=true",
            {method:"POST",headers:{"Authorization":authHeader},body:formData}
        );
        if(!uploadR.ok)throw new Error("OCR upload failed: "+uploadR.status);
        const uploadData=await uploadR.json();
        const docId=uploadData.id;
        if(!docId)throw new Error("No doc ID returned");
        const textR=await fetch(
            "https://www.googleapis.com/drive/v3/files/"+docId+"/export?mimeType=text/plain",
            {headers:{"Authorization":authHeader}}
        );
        const text=await textR.text();
        await fetch("https://www.googleapis.com/drive/v3/files/"+docId,{
            method:"DELETE",headers:{"Authorization":authHeader}
        });
        if(text&&text.length>20)return text.slice(0,4000).trim();
        throw new Error("OCR returned empty text");
    }catch(e){throw e;}
}
async function extractPdfText(arrayBuffer){
    const scriptVariants=[
        "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/4.6.82/pdf.min.js",
        "https://unpkg.com/pdfjs-dist@4.6.82/legacy/build/pdf.min.js"
    ];
    let parsed="";
    for(const src of scriptVariants){
        try{
            await loadExternalScriptOnce(src,"pdfjsLib");
            const pdfjs=window.pdfjsLib;
            if(!pdfjs||typeof pdfjs.getDocument!=="function")continue;
            const job=pdfjs.getDocument({
                data:arrayBuffer,
                disableWorker:true,
                isEvalSupported:false,
                useSystemFonts:true
            });
            const pdf=await job.promise;
            const maxPages=Math.min(pdf.numPages||0,10);
            const chunks=[];
            for(let i=1;i<=maxPages;i++){
                const page=await pdf.getPage(i);
                const tc=await page.getTextContent();
                const line=(tc.items||[])
                    .map(it=>it?.str||"")
                    .join(" ")
                    .replace(/\s+/g," ")
                    .trim();
                if(line)chunks.push(line);
            }
            parsed=chunks.join("\n").trim();
            if(parsed.length>=40)return parsed;
        }catch(e){}
    }
    const fallback=extractPdfTextFallback(arrayBuffer);
    if(fallback)return fallback;
    if(parsed)return parsed;
    try{
        console.log("Trying OCR for scanned PDF...");
        const ocrText=await extractPdfTextWithOCR(arrayBuffer);
        if(ocrText)return ocrText;
    }catch(e){console.warn("OCR failed:",e.message);}
    throw new Error("pdf text extraction returned empty");
}

function escapeHtml(s){
    return String(s||"")
        .replace(/&/g,"&amp;")
        .replace(/</g,"&lt;")
        .replace(/>/g,"&gt;")
        .replace(/\"/g,"&quot;")
        .replace(/'/g,"&#39;");
}

function normalizeAISummaryText(raw){
    return String(raw||"")
        .replace(/\r/g,"")
        .replace(/\*\*/g,"")
        .replace(/^\s*[-*]\s+/gm,"- ")
        .replace(/\n{3,}/g,"\n\n")
        .trim();
}

function renderAISummaryOutput(outputEl,raw){
    const text=normalizeAISummaryText(raw);
    if(!text){
        outputEl.innerText="No summary generated.";
        return;
    }
    const lines=text.split("\n");
    const html=[];
    for(const lineRaw of lines){
        const line=(lineRaw||"").trim();
        if(!line){
            html.push('<div style="height:6px;"></div>');
            continue;
        }
        const bullet=line.match(/^[-•]\s+(.+)$/);
        const numbered=line.match(/^\d+[.)]\s+(.+)$/);
        const headingLike=/^(summary|brief summary|what to do first|checklist|3-step checklist)\b/i.test(line);
        if(headingLike){
            html.push(`<div style="font-weight:700;opacity:0.95;margin-top:4px;">${escapeHtml(line.replace(/:\s*$/,""))}</div>`);
        }else if(bullet){
            html.push(`<div style="margin-left:10px;">• ${escapeHtml(bullet[1])}</div>`);
        }else if(numbered){
            html.push(`<div style="margin-left:10px;">• ${escapeHtml(numbered[1])}</div>`);
        }else{
            html.push(`<div>${escapeHtml(line)}</div>`);
        }
    }
    outputEl.innerHTML=html.join("");
}

const AI_SUMMARY_BOX_STYLE=`font-size:0.74em;opacity:0.78;line-height:1.55;background:${isDarkMode ? "rgba(255,255,255,0.03)" : "rgba(0,0,0,0.03)"};border:1px solid ${isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.08)"};border-radius:10px;padding:10px 12px;margin-top:8px;max-height:220px;overflow-y:auto;white-space:normal;`;

async function extractDocxText(arrayBuffer){
    await loadExternalScriptOnce("https://unpkg.com/mammoth@1.8.0/mammoth.browser.min.js","mammoth");
    const mm=window.mammoth;
    if(!mm)throw new Error("mammoth unavailable");
    const res=await mm.extractRawText({arrayBuffer});
    return (res?.value||"").replace(/\s+\n/g,"\n").trim();
}

function extractDriveIdFromUrl(rawUrl){
    const url=String(rawUrl||"").trim();
    if(!url)return "";
    const patterns=[
        /\/file\/d\/([a-zA-Z0-9_-]{10,})/,
        /\/document\/d\/([a-zA-Z0-9_-]{10,})/,
        /\/spreadsheets\/d\/([a-zA-Z0-9_-]{10,})/,
        /\/presentation\/d\/([a-zA-Z0-9_-]{10,})/,
        /[?&]id=([a-zA-Z0-9_-]{10,})/
    ];
    for(const rx of patterns){
        const m=url.match(rx);
        if(m&&m[1])return m[1];
    }
    return "";
}

function guessMimeFromTitleOrUrl(title,url){
    const src=`${title||""} ${url||""}`.toLowerCase();
    if(/\.pdf(\?|$|\s)/.test(src))return "application/pdf";
    if(/\.docx(\?|$|\s)/.test(src))return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
    if(/\.doc(\?|$|\s)/.test(src))return "application/msword";
    if(/\.txt(\?|$|\s)|\.md(\?|$|\s)|\.csv(\?|$|\s)/.test(src))return "text/plain";
    if(/docs\.google\.com\/document\//.test(src))return "application/vnd.google-apps.document";
    if(/docs\.google\.com\/spreadsheets\//.test(src))return "application/vnd.google-apps.spreadsheet";
    if(/docs\.google\.com\/presentation\//.test(src))return "application/vnd.google-apps.presentation";
    return "";
}

async function resolveMaterialFromLink(tok,m){
    const resolved={
        id:String(m?.id||"").trim(),
        mimeType:String(m?.mimeType||"").trim(),
        title:String(m?.title||"Material").trim()||"Material",
        url:String(m?.url||"").trim()
    };
    if(!resolved.mimeType)resolved.mimeType=guessMimeFromTitleOrUrl(resolved.title,resolved.url);
    if(resolved.id&&resolved.mimeType)return resolved;
    const linkId=extractDriveIdFromUrl(resolved.url);
    if(!resolved.id&&linkId)resolved.id=linkId;
    if(!tok||!resolved.id)return resolved;
    try{
        const meta=await fetch(`https://www.googleapis.com/drive/v3/files/${resolved.id}?fields=id,name,mimeType`,{headers:{"Authorization":`Bearer ${tok}`}});
        if(meta.ok){
            const data=await meta.json();
            if(data?.name&&!m?.title)resolved.title=String(data.name);
            if(data?.mimeType)resolved.mimeType=String(data.mimeType);
        }
    }catch(e){}
    if(!resolved.mimeType)resolved.mimeType=guessMimeFromTitleOrUrl(resolved.title,resolved.url);
    return resolved;
}

async function getMaterialTextForAI(materials){
    const tok=(await getWorkspaceAccessToken()).trim();
    const out=[];
    for(const m of materials.slice(0,4)){
        const resolved=await resolveMaterialFromLink(tok,m);
        const title=resolved.title||"Material";
        const mime=(resolved.mimeType||"").toLowerCase();
        const fid=resolved.id||"";
        try{
            let txt="";
            if(tok&&fid&&mime==="application/vnd.google-apps.document"){
                const r=await fetch(`https://www.googleapis.com/drive/v3/files/${fid}/export?mimeType=text/plain`,{headers:{"Authorization":`Bearer ${tok}`}});
                if(r.ok)txt=(await r.text()).trim();
            }else if(tok&&fid&&mime==="application/vnd.google-apps.spreadsheet"){
                const r=await fetch(`https://www.googleapis.com/drive/v3/files/${fid}/export?mimeType=text/csv`,{headers:{"Authorization":`Bearer ${tok}`}});
                if(r.ok)txt=(await r.text()).trim();
            }else if(tok&&fid&&mime.startsWith("text/")){
                const r=await fetch(`https://www.googleapis.com/drive/v3/files/${fid}?alt=media`,{headers:{"Authorization":`Bearer ${tok}`}});
                if(r.ok)txt=(await r.text()).trim();
            }else if(tok&&fid&&mime==="application/pdf"){
                const r=await fetch(`https://www.googleapis.com/drive/v3/files/${fid}?alt=media`,{headers:{"Authorization":`Bearer ${tok}`}});
                if(r.ok)txt=(await extractPdfText(await r.arrayBuffer())).trim();
            }else if(tok&&fid&&mime==="application/vnd.openxmlformats-officedocument.wordprocessingml.document"){
                const r=await fetch(`https://www.googleapis.com/drive/v3/files/${fid}?alt=media`,{headers:{"Authorization":`Bearer ${tok}`}});
                if(r.ok)txt=(await extractDocxText(await r.arrayBuffer())).trim();
            }else if(resolved.url&&mime){
                // Fallback for direct links when Drive id is not provided in material payload.
                const r=await fetch(resolved.url);
                if(r.ok){
                    if(mime==="application/pdf")txt=(await extractPdfText(await r.arrayBuffer())).trim();
                    else if(mime==="application/vnd.openxmlformats-officedocument.wordprocessingml.document")txt=(await extractDocxText(await r.arrayBuffer())).trim();
                    else if(mime.startsWith("text/"))txt=(await r.text()).trim();
                }
            }
            if(txt){
                out.push(`[${m.type||"FILE"}] ${title}: ${txt.slice(0,900)}`);
            }else if(mime.includes("msword")){
                out.push(`[${m.type||"FILE"}] ${title}: Legacy .doc detected. Convert to .docx or Google Doc for parsing.`);
            }else if(mime.includes("pdf")||mime.includes("word")||mime.includes("officedocument")){
                out.push(`[${m.type||"FILE"}] ${title}: Link resolved, but text extraction returned empty.`);
            }else if(resolved.url){
                out.push(`[${m.type||"FILE"}] ${title}: Link available (${resolved.url.slice(0,120)}).`);
            }else{
                out.push(`[${m.type||"FILE"}] ${title}`);
            }
        }catch(e){
            const msg=(e?.message||"parse error").toString().slice(0,80);
            out.push(`[${m.type||"FILE"}] ${title}: Could not parse (${msg}).`);
        }
    }
    return out;
}

async function runAISummaryForTask(ev,rawDesc,materials,outputEl,buttonEl){
    if(!getAIProviders().length){outputEl.innerText="Set one key: zos-openai-key / zos-gemini-key / zos-openrouter-key / zos-groq-key / zos-together-key.";return;}
    const summaryCacheKey=`zos-ai-summary-cache-${ev.id}`;
    const gapWait=getAIGapWaitMs();
    if(gapWait>0){
        const cached=localStorage.getItem(summaryCacheKey);
        const queuedMsg=`AI request queued. Try again in ${fmtAIWait(gapWait)}.`;
        if(cached)renderAISummaryOutput(outputEl,`${cached}\n\n${queuedMsg}`);
        else outputEl.innerText=queuedMsg;
        return;
    }
    const localFallback=()=>{
        const title=(ev.summary||"Untitled").replace(/^Assignment:\s*/i,"").trim();
        const due=getEventDate(ev);
        const dueTxt=due?fmtRelative(due):"No due date";
        const mat=(materials||[]).slice(0,3).map(m=>m.title).filter(Boolean);
        const matLine=mat.length?`\nChecklist:\n- Read: ${mat.join("; ")}\n- Extract requirements\n- Start implementation`:`\nChecklist:\n- Extract requirements\n- Start implementation\n- Submit + review`;
        return `Summary: ${title} (${dueTxt}) in ${getCalName(ev)}.${matLine}`;
    };
    buttonEl.style.opacity="0.55";
    buttonEl.style.pointerEvents="none";
    outputEl.innerText="Generating AI summary...";
    try{
        const title=(ev.summary||"Untitled").replace(/^Assignment:\s*/i,"").trim();
        const due=getEventDate(ev);
        const dueTxt=due?fmtRelative(due):"No due date";
        const course=getCalName(ev);
        const matLines=await getMaterialTextForAI(materials||[]);
        const descSafe=(rawDesc||"No description").slice(0,1800);
        const matSafe=(matLines.length?matLines.join("\n"):"No materials").slice(0,2400);
        const data=await guardedAIRequest(`summary-${ev.id}`,{
                max_tokens:400,
                messages:[
                    {role:"system",content:"You summarize assignment tasks clearly and concisely for students."},
                    {role:"user",content:`Task: ${title}\nCourse: ${course}\nDue: ${dueTxt}\nDescription: ${descSafe}\nMaterials (read where possible): ${matSafe}\nReturn: 1) brief summary, 2) what to do first, 3) 3-step checklist.`}
                ]
        });
        const txt=data.choices?.[0]?.message?.content?.trim();
        const finalText=txt||localFallback();
        const providerLabel=data._provider||"AI";
        renderAISummaryOutput(outputEl,finalText);
        outputEl.createDiv({attr:{style:"font-size:0.62em;opacity:0.3;margin-top:6px;font-family:var(--zos-font-mono);text-align:right;"}}).innerText=`↳ ${providerLabel}`;
        localStorage.setItem(summaryCacheKey,finalText);
    }catch(e){
        const raw=(e?.message||"request failed").toString();
        const cd=parseAIWaitError(raw,"AI_COOLDOWN");
        const gap=parseAIWaitError(raw,"AI_GAP");
        const msg=raw.replace(/^AI_ALL_PROVIDERS_FAILED:/,"").slice(0,220);
        if(cd>0){
            renderAISummaryOutput(outputEl,`AI temporarily rate-limited. Retry in ${fmtAIWait(cd)}.\n\n${localFallback()}`);
        }else if(gap>0){
            renderAISummaryOutput(outputEl,`AI request queued. Retry in ${fmtAIWait(gap)}.\n\n${localFallback()}`);
        }else{
            const isQuota=/\bquota\b|exceeded your current quota|429/i.test(msg);
            const friendly=isQuota?"Gemini free-tier quota used for now. Add another key (OpenAI/OpenRouter/Groq) in settings, or try again later.":msg.slice(0,120);
            renderAISummaryOutput(outputEl,`AI unavailable: ${friendly}\n\n${localFallback()}`);
        }
    }finally{
        buttonEl.style.opacity="";
        buttonEl.style.pointerEvents="";
    }
}

function renderEventCard(parent,ev,done){
    const due=getEventDate(ev),dl=due?getDaysLeft(due):999,secs=due?getSecsLeft(due):null,prio=getPrio(ev);
    const u=done?{border:"rgba(0,255,136,0.15)",bg:"rgba(0,255,136,0.03)",acc:"#00ff88",bbg:"rgba(0,255,136,0.1)"}:urgencyStyle(dl,prio);
    const gcrLink=getGCRLink(ev),calName=getCalName(ev);
    const title=(ev.summary||"Untitled").replace(/^Assignment:\s*/i,"").trim(),note=getNote(ev);
    const card=parent.createDiv({attr:{style:`display:flex;align-items:stretch;border-radius:14px;border:1px solid ${u.border};background:${u.bg};margin-bottom:9px;overflow:hidden;transition:transform 0.18s ease;${done?"opacity:0.6;":""};cursor:pointer;`}});
    
    card.onclick=async e=>{
        if(e.target.closest("button,.zos-action-btn,[data-due]"))return;
        const ov2=document.body.createDiv({cls:"zos-modal-overlay"});
        const moText2=modalText;
        const moBorder2=modalBorder;
        const mo2=ov2.createDiv({cls:"zos-modal",attr:{style:`width:460px;background:${modalBg};${modalBlur}color:${modalText};border-color:${modalBorder};box-shadow:${modalShadow};`}});
        const cl2=()=>ov2.remove();
        ov2.onclick=e2=>{if(e2.target===ov2)cl2();};
        mo2.createDiv({cls:"zos-modal-title",attr:{style:`color:${modalText};`},text:title});
        const meta=mo2.createDiv({attr:{style:"display:flex;align-items:center;gap:8px;flex-wrap:wrap;margin-bottom:16px;"}});
        if(due)meta.createDiv({attr:{style:`font-size:0.72em;font-weight:700;padding:2px 9px;border-radius:10px;color:${u.acc};background:${u.bbg};`}}).innerText=done?"Submitted":fmtRelative(due);
        meta.createDiv({attr:{style:`font-size:0.72em;font-weight:600;color:${isDarkMode?'rgba(255,255,255,0.5)':'rgba(0,0,0,0.5)'};`}}).innerText=calName;
        if(due)meta.createDiv({attr:{style:`font-size:0.7em;color:${isDarkMode?'rgba(255,255,255,0.3)':'rgba(0,0,0,0.35)'};`}}).innerText=fmtDate(due);
        const rawDesc=(ev.description||"").replace(/https:\/\/classroom\.google\.com\/[^\s<>"\\]*/g,"").replace(/<[^>]+>/g," ").replace(/\s+/g," ").trim();
        if(rawDesc)mo2.createDiv({attr:{style:`font-size:0.82em;line-height:1.6;background:${isDarkMode?'rgba(255,255,255,0.03)':'rgba(0,0,0,0.04)'};border-radius:10px;padding:12px;margin-bottom:16px;border:1px solid ${isDarkMode?'rgba(255,255,255,0.05)':'rgba(0,0,0,0.08)'};max-height:120px;overflow-y:auto;white-space:pre-wrap;color:${isDarkMode?'rgba(255,255,255,0.75)':'rgba(0,0,0,0.75)'};`}}).innerText=rawDesc;

        // -- NOTE ----------------------------
        const noteSection=mo2.createDiv({attr:{style:"margin-bottom:12px;"}});
        noteSection.createDiv({attr:{style:`font-size:0.65em;font-weight:700;letter-spacing:1px;color:${isDarkMode?'rgba(255,255,255,0.35)':'rgba(0,0,0,0.4)'};margin-bottom:6px;`}}).innerText="NOTE";
        const noteInput=noteSection.createEl("textarea",{attr:{rows:"2",placeholder:"Add a note...",style:`width:100%;background:${isDarkMode ? "rgba(255,255,255,0.04)" : "rgba(0,0,0,0.03)"};border:1px solid ${isDarkMode ? "rgba(255,255,255,0.08)" : "rgba(0,0,0,0.12)"};border-radius:10px;padding:10px 12px;color:${isDarkMode ? "#fff" : "#1f2937"};font-family:var(--zos-font-main);font-size:0.8em;outline:none;resize:none;box-sizing:border-box;transition:border-color 0.2s;`}});
        noteInput.value=getNote(ev);
        noteInput.onfocus=()=>{noteInput.style.borderColor="var(--zos-accent)";};
        noteInput.onblur=()=>{noteInput.style.borderColor=isDarkMode ? "rgba(255,255,255,0.08)" : "rgba(0,0,0,0.12)";setNote(ev,noteInput.value);renderListView();};

        // -- MATERIALS ---------------
        const attachSection=mo2.createDiv({attr:{style:"margin-bottom:16px;"}});
        attachSection.createDiv({attr:{style:`font-size:0.65em;font-weight:700;letter-spacing:1px;color:${isDarkMode?'rgba(255,255,255,0.35)':'rgba(0,0,0,0.4)'};margin-bottom:8px;`}}).innerText="MATERIALS";
        const attachList=attachSection.createDiv({attr:{style:"display:flex;flex-direction:column;gap:6px;"}});
        const aiMaterials=[];
        attachList.createDiv({attr:{style:"font-size:0.75em;opacity:0.25;font-style:italic;"}}).innerText="Loading materials...";
        const lnk=getGCRLink(ev);
        (async()=>{
            try{
                const m=lnk?.match(/\/c\/([^/]+)\/a\/([^/]+)/);
                if(!m){attachList.innerHTML="";attachList.createDiv({attr:{style:"font-size:0.75em;opacity:0.25;"}}).innerText="No materials link found.";return;}
                const courseId=atob(m[1]),workId=atob(m[2]);
                const tok=(await getWorkspaceAccessToken()).trim();
                if(!tok){
                    attachList.innerHTML="";
                    attachList.createDiv({attr:{style:"font-size:0.75em;opacity:0.35;"}}).innerText="Google Workspace is not connected. Reconnect the plugin and try again.";
                    return;
                }
                const r=await fetch(`https://classroom.googleapis.com/v1/courses/${courseId}/courseWork/${workId}`,{headers:{"Authorization":`Bearer ${tok}`}});
                if(!r.ok){
                    throw new Error(`Classroom API ${r.status}`);
                }
                const d=await r.json();
                attachList.innerHTML="";
                if(!d.materials||!d.materials.length){attachList.createDiv({attr:{style:"font-size:0.75em;opacity:0.25;font-style:italic;"}}).innerText="No materials attached.";return;}
                d.materials.forEach(mat=>{
                    let fileTitle="",fileUrl="",fileType="";
                    let fileId="",mimeType="";
                    if(mat.driveFile){fileTitle=mat.driveFile.driveFile?.title||"Drive File";fileUrl=mat.driveFile.driveFile?.alternateLink||"";fileType=fileTitle.split(".").pop().toUpperCase()||"FILE";fileId=mat.driveFile.driveFile?.id||"";mimeType=mat.driveFile.driveFile?.mimeType||"";}
                    else if(mat.youtubeVideo){fileTitle=mat.youtubeVideo.title||"YouTube Video";fileUrl=mat.youtubeVideo.alternateLink||`https://youtu.be/${mat.youtubeVideo.id}`;fileType="VIDEO";}
                    else if(mat.link){fileTitle=mat.link.title||mat.link.url||"Link";fileUrl=mat.link.url||"";fileType="LINK";}
                    else if(mat.form){fileTitle=mat.form.title||"Form";fileUrl=mat.form.formUrl||"";fileType="FORM";}
                    if(!fileUrl)return;
                    aiMaterials.push({title:fileTitle,type:fileType,url:fileUrl,id:fileId,mimeType});
                    const typeColors={"PDF":"#ff5555","DOCX":"#00aaff","DOC":"#00aaff","PPTX":"#ff8c00","PPT":"#ff8c00","XLSX":"#00ff88","XLS":"#00ff88","VIDEO":"#b450ff","LINK":"#00e5ff","FORM":"#ffc800"};
                    const tc=typeColors[fileType]||"rgba(255,255,255,0.4)";
                    const row=attachList.createDiv({attr:{style:`display:flex;align-items:center;gap:10px;padding:9px 12px;background:${isDarkMode ? "rgba(255,255,255,0.03)" : "rgba(0,0,0,0.02)"};border-radius:10px;border:1px solid ${isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.08)"};cursor:pointer;transition:all 0.2s;`}});
                    row.createDiv({attr:{style:`font-size:0.6em;font-weight:800;padding:2px 6px;border-radius:5px;background:${tc}22;color:${tc};flex-shrink:0;`}}).innerText=fileType;
                    row.createDiv({attr:{style:"font-size:0.8em;font-weight:600;flex:1;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"}}).innerText=fileTitle;
                    row.createDiv({attr:{style:"font-size:0.75em;opacity:0.3;flex-shrink:0;"}}).innerText="↗";
                    row.onmouseenter=()=>{row.style.background=isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.04)";row.style.borderColor=`${tc}44`;};
                    row.onmouseleave=()=>{row.style.background=isDarkMode ? "rgba(255,255,255,0.03)" : "rgba(0,0,0,0.02)";row.style.borderColor=isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.08)";};
                    row.onclick=e3=>{e3.stopPropagation();openMaterialModal(fileTitle,fileUrl,fileType,mimeType);};
                });
            }catch(err){
                attachList.innerHTML="";
                attachList.createDiv({attr:{style:"font-size:0.75em;opacity:0.25;font-style:italic;"}}).innerText="Could not load materials.";
            }
        })();

        const aiSection=mo2.createDiv({attr:{style:"margin-bottom:12px;"}});
        const aiBtn=aiSection.createEl("button",{attr:{style:"width:100%;font-size:0.75em;font-weight:700;padding:8px;border-radius:9px;background:rgba(var(--zos-accent-rgb),0.1);color:var(--zos-accent);border:1px solid rgba(var(--zos-accent-rgb),0.24);cursor:pointer;"}});
        aiBtn.innerText="AI Summary";
        const aiOut=aiSection.createDiv({attr:{style:AI_SUMMARY_BOX_STYLE}});
        aiOut.innerText="Click AI Summary to analyze description + materials.";
        aiBtn.onclick=()=>{runAISummaryForTask(ev,rawDesc,aiMaterials,aiOut,aiBtn);};

        // -- ACTION BUTTONS --------------
        const btnRow=mo2.createDiv({attr:{style:"display:flex;gap:8px;margin-bottom:8px;"}});
        const curPrio=getPrio(ev);
        const prioBtn=btnRow.createEl("button",{attr:{style:`flex:1;font-size:0.75em;font-weight:700;padding:8px;border-radius:9px;background:${curPrio==="HIGH"?"rgba(180,80,255,0.12)":(isDarkMode?"rgba(255,255,255,0.05)":"rgba(0,0,0,0.05)")};color:${curPrio==="HIGH"?"#b450ff":(isDarkMode?"rgba(255,255,255,0.5)":"rgba(0,0,0,0.55)")};border:1px solid ${curPrio==="HIGH"?"rgba(180,80,255,0.3)":(isDarkMode?"rgba(255,255,255,0.08)":"rgba(0,0,0,0.1)")};cursor:pointer;transition:all 0.2s;`}});
        prioBtn.innerText=curPrio==="HIGH"?"⭐ High Priority":"☆ Set High Priority";
        prioBtn.onclick=()=>{
            const newPrio=getPrio(ev)==="HIGH"?"NORMAL":"HIGH";
            setPrio(ev,newPrio);
            prioBtn.innerText=newPrio==="HIGH"?"⭐ High Priority":"☆ Set High Priority";
            prioBtn.style.background=newPrio==="HIGH"?"rgba(180,80,255,0.12)":(isDarkMode?"rgba(255,255,255,0.05)":"rgba(0,0,0,0.05)");
            prioBtn.style.color=newPrio==="HIGH"?"#b450ff":(isDarkMode?"rgba(255,255,255,0.5)":"rgba(0,0,0,0.55)");
            prioBtn.style.borderColor=newPrio==="HIGH"?"rgba(180,80,255,0.3)":(isDarkMode?"rgba(255,255,255,0.08)":"rgba(0,0,0,0.1)");
            renderSummaryBar();renderListView();
        };
        if(lnk){
            const ob=btnRow.createEl("button",{attr:{style:`flex:1;font-size:0.75em;font-weight:700;padding:8px;border-radius:9px;background:rgba(var(--zos-accent-rgb),0.1);color:var(--zos-accent);border:1px solid rgba(var(--zos-accent-rgb),0.2);cursor:pointer;`}});
            ob.innerText="↗ Open in GCR";
            ob.onclick=()=>{window.open(lnk,"_blank");};
        }

        // -- LINKED FILES (multi-file attachment) -----------------
        const fileLinksKey=`zos-file-links-${ev.id}`;
        const legacyKey=`zos-note-link-${ev.id}`;
        (()=>{const old=localStorage.getItem(legacyKey);if(old){const cur=JSON.parse(localStorage.getItem(fileLinksKey)||"[]");if(!cur.includes(old)){cur.push(old);localStorage.setItem(fileLinksKey,JSON.stringify(cur));}localStorage.removeItem(legacyKey);}})();

        const getLinks=()=>JSON.parse(localStorage.getItem(fileLinksKey)||"[]");
        const saveLinks=l=>localStorage.setItem(fileLinksKey,JSON.stringify(l));
        const addLinks=paths=>{const l=getLinks();paths.forEach(p=>{if(!l.includes(p))l.push(p);});saveLinks(l);};
        const removeLink=p=>{saveLinks(getLinks().filter(x=>x!==p));};
        const fileIcon=p=>{const e=(p.split(".").pop()||"").toLowerCase();if(e==="md")return"📄";if(e==="pdf")return"📕";if(["doc","docx"].includes(e))return"📝";if(["xls","xlsx","csv"].includes(e))return"📊";if(["png","jpg","jpeg","gif","svg","webp"].includes(e))return"🖼";return"📦";};

        const linkedFilesSection=mo2.createDiv({attr:{style:"margin-bottom:10px;"}});
        const fileListEl=linkedFilesSection.createDiv({attr:{style:"display:flex;flex-direction:column;gap:3px;max-height:110px;overflow-y:auto;margin-bottom:7px;padding-right:2px;"}});

        const renderLinkedFiles=()=>{
            fileListEl.innerHTML="";
            const links=getLinks();
            if(links.length){
                links.forEach(p=>{
                    const row=fileListEl.createDiv({attr:{style:`display:flex;align-items:center;gap:6px;padding:4px 8px;border-radius:7px;`}});
                    row.createDiv({attr:{style:"font-size:0.75em;flex-shrink:0;opacity:0.65;"}}).innerText=fileIcon(p);
                    row.createDiv({attr:{style:`font-size:0.73em;flex:1;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;opacity:0.7;cursor:pointer;`}}).innerText=p.split("/").pop();
                    row.children[1].onclick=()=>{app.workspace.openLinkText(p,"",false);cl2();};
                    row.onmouseenter=()=>{row.style.background=isDarkMode?"rgba(255,255,255,0.04)":"rgba(0,0,0,0.04)";};
                    row.onmouseleave=()=>{row.style.background="";};
                    const unlinkBtn=row.createEl("button",{attr:{style:`font-size:0.6em;padding:2px 6px;border-radius:5px;background:transparent;color:${isDarkMode?"rgba(255,255,255,0.2)":"rgba(0,0,0,0.2)"};border:none;cursor:pointer;flex-shrink:0;opacity:0;transition:opacity 0.15s;`}});
                    unlinkBtn.innerText="✕";
                    row.onmouseenter=()=>{row.style.background=isDarkMode?"rgba(255,255,255,0.04)":"rgba(0,0,0,0.04)";unlinkBtn.style.opacity="1";};
                    row.onmouseleave=()=>{row.style.background="";unlinkBtn.style.opacity="0";};
                    unlinkBtn.onclick=e=>{e.stopPropagation();removeLink(p);renderLinkedFiles();};
                });
            }
        };
        renderLinkedFiles();

        // Single "Link Files" button
        const linkFilesBtn=linkedFilesSection.createEl("button",{attr:{style:`width:100%;font-size:0.72em;font-weight:700;padding:7px;border-radius:9px;background:${isDarkMode?"rgba(255,255,255,0.04)":"rgba(0,0,0,0.04)"};color:${isDarkMode?"rgba(255,255,255,0.5)":"rgba(0,0,0,0.5)"};border:1px dashed ${isDarkMode?"rgba(255,255,255,0.1)":"rgba(0,0,0,0.12)"};cursor:pointer;transition:all 0.2s;`}});
        linkFilesBtn.innerText="📎 Link Files";
        linkFilesBtn.onmouseenter=()=>{linkFilesBtn.style.borderColor="var(--zos-accent)";linkFilesBtn.style.color="var(--zos-accent)";};
        linkFilesBtn.onmouseleave=()=>{linkFilesBtn.style.borderColor=isDarkMode?"rgba(255,255,255,0.1)":"rgba(0,0,0,0.12)";linkFilesBtn.style.color=isDarkMode?"rgba(255,255,255,0.5)":"rgba(0,0,0,0.5)";};

        linkFilesBtn.onclick=()=>{
            const fpOv=document.body.createDiv({cls:"zos-modal-overlay"});
            const fpMo=fpOv.createDiv({cls:"zos-modal",attr:{style:`width:500px;max-height:87vh;display:flex;flex-direction:column;background:${modalBg};${modalBlur}color:${modalText};border-color:${modalBorder};box-shadow:${modalShadow};`}});
            fpOv.onclick=e=>{if(e.target===fpOv)fpOv.remove();};
            fpMo.createDiv({cls:"zos-modal-title",attr:{style:`color:${modalText};`},text:"LINK FILES"});

            const selectedPaths=new Set(); // paths of files selected in browser
            let currentPath="/";

            // -- Breadcrumb --
            const bcEl=fpMo.createDiv({attr:{style:`display:flex;align-items:center;gap:4px;flex-wrap:wrap;padding:7px 12px;background:${isDarkMode?"rgba(255,255,255,0.03)":"rgba(0,0,0,0.03)"};border-radius:10px;margin-bottom:9px;border:1px solid ${isDarkMode?"rgba(255,255,255,0.06)":"rgba(0,0,0,0.08)"};min-height:34px;`}});

            // -- File/folder list --
            const flEl=fpMo.createDiv({attr:{style:"flex:1;overflow-y:auto;display:flex;flex-direction:column;gap:3px;padding-right:2px;margin-bottom:10px;"}});

            // -- New folder row --
            const newFolderRow=fpMo.createDiv({attr:{style:"display:flex;gap:7px;margin-bottom:10px;"}});
            const newFolderInp=newFolderRow.createEl("input",{attr:{type:"text",placeholder:"New folder name…",style:`flex:1;background:${isDarkMode?"rgba(255,255,255,0.04)":"rgba(0,0,0,0.03)"};border:1px solid ${isDarkMode?"rgba(255,255,255,0.08)":"rgba(0,0,0,0.12)"};border-radius:9px;padding:7px 11px;color:${isDarkMode?"#fff":"#1f2937"};font-size:0.78em;outline:none;`}});
            const newFolderBtn=newFolderRow.createEl("button",{attr:{style:"padding:7px 13px;border-radius:9px;background:rgba(var(--zos-accent-rgb),0.1);color:var(--zos-accent);border:1px solid rgba(var(--zos-accent-rgb),0.22);font-size:0.72em;font-weight:700;cursor:pointer;white-space:nowrap;"}});
            newFolderBtn.innerText="📁 Create";
            newFolderInp.onfocus=()=>{newFolderInp.style.borderColor="var(--zos-accent)";};
            newFolderInp.onblur=()=>{newFolderInp.style.borderColor=isDarkMode?"rgba(255,255,255,0.08)":"rgba(0,0,0,0.12)";};
            newFolderBtn.onclick=async()=>{
                const name=newFolderInp.value.trim();if(!name)return;
                const np=currentPath==="/"?name:`${currentPath}/${name}`;
                try{await app.vault.createFolder(np);newFolderInp.value="";currentPath=np;renderBrowser();}
                catch(e){new Notice(`Error: ${e.message}`);}
            };
            newFolderInp.onkeydown=e=>{if(e.key==="Enter")newFolderBtn.click();};

            // -- Note name row --
            fpMo.createDiv({attr:{style:`font-size:0.62em;font-weight:700;letter-spacing:1.1px;opacity:0.3;margin-bottom:5px;`}}).innerText="NEW NOTE NAME";
            const noteRow=fpMo.createDiv({attr:{style:"display:flex;gap:7px;margin-bottom:10px;"}});
            const noteNameInp=noteRow.createEl("input",{cls:"zos-modal-input",attr:{type:"text",value:title,style:"flex:1;margin-bottom:0;"}});
            noteNameInp.onfocus=()=>{noteNameInp.style.borderColor="var(--zos-accent)";};
            noteNameInp.onblur=()=>{noteNameInp.style.borderColor=isDarkMode?"rgba(255,255,255,0.1)":"rgba(0,0,0,0.12)";};
            const createNoteBtn=noteRow.createEl("button",{cls:"zos-modal-btn zos-btn-save",attr:{style:"flex:0 0 auto;white-space:nowrap;"}});
            createNoteBtn.innerText="✦ Create & Link";
            createNoteBtn.onclick=async()=>{
                const noteName=noteNameInp.value.trim()||title;
                const notePath=currentPath==="/"?`${noteName}.md`:`${currentPath}/${noteName}.md`;
                try{
                    let file=app.vault.getAbstractFileByPath(notePath);
                    if(!file)file=await app.vault.create(notePath,"");
                    addLinks([notePath]);fpOv.remove();renderLinkedFiles();
                    new Notice(`Created & linked: ${noteName}.md`);
                }catch(e){new Notice(`Error: ${e.message}`);}
            };

            // -- Bottom action row --
            let confirmBtn;
            const bottomRow=fpMo.createDiv({attr:{style:"display:flex;gap:8px;"}});
            confirmBtn=bottomRow.createEl("button",{cls:"zos-modal-btn zos-btn-save",attr:{style:"flex:1;"}});
            bottomRow.createEl("button",{cls:"zos-modal-btn zos-btn-cancel",text:"Cancel",attr:{style:"flex:0 0 auto;padding:8px 16px;"}}).onclick=()=>fpOv.remove();

            const updateConfirm=()=>{
                const n=selectedPaths.size;
                confirmBtn.innerText=n?`Link ${n} file${n>1?"s":""}…`:"(select files to link)";
                confirmBtn.disabled=n===0;
                confirmBtn.style.opacity=n?"1":"0.38";
                confirmBtn.style.cursor=n?"pointer":"default";
            };
            confirmBtn.onclick=()=>{
                if(!selectedPaths.size)return;
                addLinks([...selectedPaths]);fpOv.remove();renderLinkedFiles();
                new Notice(`Linked ${selectedPaths.size} file${selectedPaths.size>1?"s":""}!`);
            };

            // -- Breadcrumb renderer --
            const renderBC=()=>{
                bcEl.innerHTML="";
                if(currentPath==="/"){
                    bcEl.createDiv({attr:{style:"font-size:0.72em;font-weight:700;color:var(--zos-accent);"}}).innerText="Vault Root";return;
                }
                const parts=currentPath.split("/");
                const rc=bcEl.createDiv({attr:{style:`font-size:0.72em;color:${isDarkMode?"rgba(255,255,255,0.4)":"rgba(0,0,0,0.5)"};cursor:pointer;`}});
                rc.innerText="Root";rc.onclick=()=>{currentPath="/";renderBrowser();};
                bcEl.createDiv({attr:{style:"font-size:0.7em;opacity:0.3;"}}).innerText="›";
                parts.forEach((p,i)=>{
                    const isLast=i===parts.length-1;
                    const c=bcEl.createDiv({attr:{style:`font-size:0.72em;font-weight:${isLast?"700":"400"};color:${isLast?"var(--zos-accent)":(isDarkMode?"rgba(255,255,255,0.4)":"rgba(0,0,0,0.5)")};${isLast?"":"cursor:pointer;"}white-space:nowrap;`}});
                    c.innerText=p;
                    if(!isLast){c.onclick=()=>{currentPath=parts.slice(0,i+1).join("/");renderBrowser();};}
                    if(!isLast)bcEl.createDiv({attr:{style:"font-size:0.7em;opacity:0.3;"}}).innerText="›";
                });
            };

            // -- Main browser renderer: folders first, then files --
            const renderBrowser=()=>{
                flEl.innerHTML="";renderBC();
                const folder=currentPath==="/"?app.vault.getRoot():app.vault.getAbstractFileByPath(currentPath);
                if(!folder)return;
                const children=folder.children||[];
                const dirs=children.filter(f=>f.children).sort((a,b)=>a.name.localeCompare(b.name));
                const files=children.filter(f=>!f.children).sort((a,b)=>a.name.localeCompare(b.name));
                const already=getLinks();

                // Up row
                if(currentPath!=="/"){
                    const up=flEl.createDiv({attr:{style:`display:flex;align-items:center;gap:10px;padding:8px 12px;border-radius:9px;cursor:pointer;color:${isDarkMode?"rgba(255,255,255,0.4)":"rgba(0,0,0,0.45)"};font-size:0.82em;`}});
                    up.createDiv({attr:{style:"width:18px;text-align:center;"}}).innerText="↑";up.createDiv({text:".. (go up)"});
                    up.onmouseenter=()=>{up.style.background=isDarkMode?"rgba(255,255,255,0.04)":"rgba(0,0,0,0.04)";};
                    up.onmouseleave=()=>{up.style.background="";};
                    up.onclick=()=>{const p2=currentPath.split("/");currentPath=p2.length<=1?"/":p2.slice(0,-1).join("/");renderBrowser();};
                }

                if(!dirs.length&&!files.length){
                    flEl.createDiv({attr:{style:"text-align:center;padding:18px;opacity:0.28;font-size:0.78em;"}}).innerText="Empty folder";
                    return;
                }

                // Folders
                dirs.forEach(f=>{
                    const row=flEl.createDiv({attr:{style:`display:flex;align-items:center;gap:10px;padding:8px 12px;border-radius:9px;cursor:pointer;border:1px solid transparent;`}});
                    row.createDiv({attr:{style:"width:18px;text-align:center;font-size:0.9em;"}}).innerText="📁";
                    row.createDiv({attr:{style:"font-size:0.82em;font-weight:600;flex:1;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"}}).innerText=f.name;
                    row.createDiv({attr:{style:"font-size:0.75em;opacity:0.3;flex-shrink:0;"}}).innerText="›";
                    row.onmouseenter=()=>{row.style.background=isDarkMode?"rgba(255,255,255,0.05)":"rgba(0,0,0,0.04)";row.style.borderColor=isDarkMode?"rgba(255,255,255,0.07)":"rgba(0,0,0,0.09)";};
                    row.onmouseleave=()=>{row.style.background="";row.style.borderColor="transparent";};
                    row.onclick=()=>{currentPath=f.path;renderBrowser();};
                });

                // Files (selectable)
                files.forEach(f=>{
                    const isLinked=already.includes(f.path);
                    const isSel=selectedPaths.has(f.path);
                    const row=flEl.createDiv({attr:{style:`display:flex;align-items:center;gap:9px;padding:7px 12px;border-radius:9px;cursor:pointer;border:1px solid ${isLinked?"rgba(var(--zos-accent-rgb),0.2)":isSel?"rgba(var(--zos-accent-rgb),0.3)":"transparent"};background:${isLinked?"rgba(var(--zos-accent-rgb),0.05)":isSel?"rgba(var(--zos-accent-rgb),0.09)":"transparent"};transition:all 0.12s;`}});
                    // checkbox
                    const chk=row.createDiv({attr:{style:`width:14px;height:14px;border-radius:3px;border:1.5px solid ${isLinked||isSel?"var(--zos-accent)":(isDarkMode?"rgba(255,255,255,0.2)":"rgba(0,0,0,0.2)")};background:${isLinked||isSel?"var(--zos-accent)":"transparent"};flex-shrink:0;display:flex;align-items:center;justify-content:center;font-size:9px;color:#fff;transition:all 0.12s;`}});
                    if(isLinked||isSel)chk.innerText="✓";
                    row.createDiv({attr:{style:"font-size:0.9em;flex-shrink:0;"}}).innerText=fileIcon(f.path);
                    row.createDiv({attr:{style:"font-size:0.82em;font-weight:500;flex:1;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"}}).innerText=f.name;
                    if(isLinked){
                        row.createDiv({attr:{style:`font-size:0.6em;font-weight:700;padding:2px 6px;border-radius:5px;background:rgba(var(--zos-accent-rgb),0.12);color:var(--zos-accent);flex-shrink:0;white-space:nowrap;`}}).innerText="linked";
                    } else {
                        row.onmouseenter=()=>{if(!isSel)row.style.background=isDarkMode?"rgba(255,255,255,0.05)":"rgba(0,0,0,0.04)";};
                        row.onmouseleave=()=>{if(!selectedPaths.has(f.path))row.style.background="transparent";};
                        row.onclick=e=>{
                            if(!e.ctrlKey&&!e.metaKey){
                                if(selectedPaths.has(f.path))selectedPaths.delete(f.path);
                                else{selectedPaths.clear();selectedPaths.add(f.path);}
                            } else {
                                if(selectedPaths.has(f.path))selectedPaths.delete(f.path);
                                else selectedPaths.add(f.path);
                            }
                            renderBrowser();updateConfirm();
                        };
                    }
                });
            };
            renderBrowser();
            updateConfirm();
            noteNameInp.focus();noteNameInp.select();
        };

        const db=mo2.createEl("button",{attr:{style:`width:100%;font-size:0.75em;font-weight:700;padding:8px;border-radius:9px;background:${done?(isDarkMode?"rgba(255,85,85,0.12)":"rgba(220,38,38,0.08)"):(isDarkMode?"rgba(0,255,136,0.08)":"rgba(0,160,80,0.1)")};color:${done?(isDarkMode?"#ff5555":"#dc2626"):(isDarkMode?"#00ff88":"#00a050")};border:1px solid ${done?(isDarkMode?"rgba(255,85,85,0.2)":"rgba(220,38,38,0.2)"):(isDarkMode?"rgba(0,255,136,0.2)":"rgba(0,160,80,0.25)")};cursor:pointer;margin-bottom:8px;`}});
        db.innerText=done?"↩ Undo Done":"✓ Mark Done";
        db.onclick=()=>{toggleDone(ev);renderHeaderStats();renderSummaryBar();renderListView();cl2();};
        mo2.createEl("button",{cls:"zos-modal-btn zos-btn-cancel",attr:{style:`width:100%;background:${isDarkMode?'rgba(255,255,255,0.05)':'rgba(0,0,0,0.05)'};color:${moText2};border:1px solid ${moBorder2};`},text:"Close"}).onclick=cl2;
    };
    
    card.createDiv({attr:{style:`width:4px;flex-shrink:0;background:${u.acc};`}});
    const chkW=card.createDiv({attr:{style:"display:flex;align-items:center;padding:0 12px;"}});
    const chkBorder = done ? "#00bb66" : isDarkMode ? "rgba(255,255,255,0.18)" : "rgba(0,0,0,0.25)";
    const chkBg = done ? (isDarkMode ? "#00ff88" : "#00bb66") : "transparent";
    const chk=chkW.createDiv({attr:{style:`width:19px;height:19px;border-radius:5px;border:2px solid ${chkBorder};background:${chkBg};flex-shrink:0;display:flex;align-items:center;justify-content:center;cursor:pointer;transition:all 0.18s;font-size:11px;color:${isDarkMode?"#000":"#fff"};`}});
    if(done)chk.innerText="✓";
    chk.onclick=e=>{e.stopPropagation();toggleDone(ev);renderHeaderStats();renderSummaryBar();renderListView();if(pipelineView==="month")renderMonth();};
    chk.onmouseenter=()=>{if(isDone(ev)){chk.innerText="↩";chk.style.background="rgba(255,85,85,0.3)";chk.style.borderColor="#ff5555";chk.style.color="#fff";}else{chk.innerText="✓";chk.style.borderColor="#00ff88";chk.style.background="rgba(0,255,136,0.15)";}};
    chk.onmouseleave=()=>{if(isDone(ev)){chk.innerText="✓";chk.style.background=isDarkMode?"#00ff88":"#00bb66";chk.style.borderColor=isDarkMode?"#00ff88":"#00bb66";chk.style.color=isDarkMode?"#000":"#fff";}else{chk.innerText="";chk.style.borderColor=isDarkMode?"rgba(255,255,255,0.18)":"rgba(0,0,0,0.25)";chk.style.background="transparent";}};
    const cardTextColor = isDarkMode ? "inherit" : "#0f0f0f";
    const cnt=card.createDiv({attr:{style:`flex:1;padding:12px 14px 12px 0;min-width:0;color:${cardTextColor};`}});
    const r1=cnt.createDiv({attr:{style:"display:flex;align-items:flex-start;gap:8px;margin-bottom:5px;"}});
    r1.createDiv({attr:{style:`font-weight:700;font-size:0.9em;line-height:1.3;flex:1;min-width:0;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;${done?"text-decoration:line-through;opacity:0.5;":""}`}}).innerText=title;
    if(prio==="HIGH"&&!done)r1.createDiv({attr:{style:"font-size:0.6em;font-weight:800;padding:2px 7px;border-radius:6px;background:rgba(180,80,255,0.15);color:#b450ff;white-space:nowrap;flex-shrink:0;"}}).innerText="↑ HIGH";
    if(due)r1.createDiv({attr:{style:`font-size:0.65em;font-weight:800;padding:2px 9px;border-radius:12px;white-space:nowrap;flex-shrink:0;color:${u.acc};background:${u.bbg};`}}).innerText=done?"Submitted":fmtRelative(due);
    const r2=cnt.createDiv({attr:{style:"display:flex;align-items:center;gap:7px;flex-wrap:wrap;"}});
    r2.createDiv({attr:{style:`font-size:0.7em;opacity:0.55;font-weight:600;color:${isDarkMode?"inherit":"#334155"};`}}).innerText=calName;
    if(due){r2.createDiv({attr:{style:"font-size:0.62em;opacity:0.35;"}}).innerText="·";r2.createDiv({attr:{style:`font-size:0.67em;opacity:0.5;color:${isDarkMode?"inherit":"#475569"};`}}).innerText=fmtDate(due);}
    if(note)cnt.createDiv({attr:{style:`font-size:0.7em;opacity:0.5;margin-top:4px;font-style:italic;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;color:${isDarkMode?"inherit":"#475569"};`}}).innerText=`✎ ${note}`;
    if(due&&secs!==null&&!done){
        const tr=cnt.createDiv({attr:{style:"display:flex;align-items:center;gap:5px;margin-top:5px;"}});
        tr.createDiv({attr:{style:"font-size:0.65em;opacity:0.3;"}}).innerText="◷";
        const timerEl=tr.createDiv({attr:{style:`font-size:0.7em;font-weight:700;font-family:var(--zos-font-mono);color:${timerColor(secs)};letter-spacing:0.3px;`}});
        timerEl.setAttribute("data-due",due.getTime());timerEl.innerText=fmtCountdown(secs);
    }

}

// -- TIMERS ------------------------------
function startTimers(){
    stopTimers();
    timerInterval=setInterval(()=>{
        if(!listCont)return;
        listCont.querySelectorAll("[data-due]").forEach(el=>{
            const secs=Math.floor((parseInt(el.getAttribute("data-due"))-Date.now())/1000);
            el.style.color=timerColor(secs);el.innerText=fmtCountdown(secs);
        });
    },1000);
}
function stopTimers(){if(timerInterval){clearInterval(timerInterval);timerInterval=null;}}

// -- MONTH VIEW ----------------
function renderMonth(){
    if(!calGridEl)return;
    calGridEl.innerHTML="";
    const yr=calViewDate.getFullYear(),mo=calViewDate.getMonth();
    calTitleEl.innerText=new Date(yr,mo,1).toLocaleDateString("en-US",{month:"long",year:"numeric"}).toUpperCase();
    ["S","M","T","W","T","F","S"].forEach(d=>calGridEl.createDiv({attr:{style:"text-align:center;font-size:0.6em;font-weight:700;letter-spacing:1px;opacity:0.3;padding:5px 0;"}}).innerText=d);
    const firstDay=new Date(yr,mo,1).getDay(),daysInMonth=new Date(yr,mo+1,0).getDate();
    const today=new Date();today.setHours(0,0,0,0);
    const evMap={};
    allEvents.forEach(ev=>{
        const d=getEventDate(ev);if(!d)return;
        const k=`${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,"0")}-${String(d.getDate()).padStart(2,"0")}`;
        if(!evMap[k])evMap[k]=[];evMap[k].push(ev);
    });
    for(let i=0;i<firstDay;i++)calGridEl.createDiv();
    for(let day=1;day<=daysInMonth;day++){
        const cd=new Date(yr,mo,day);cd.setHours(0,0,0,0);
        const k=`${yr}-${String(mo+1).padStart(2,"0")}-${String(day).padStart(2,"0")}`;
        const dayEvs=evMap[k]||[];
        const isToday=cd.getTime()===today.getTime(),isPast=cd<today;
        const allDone=dayEvs.length>0&&dayEvs.every(ev=>isDone(ev));
        const hasPending=dayEvs.some(ev=>!isDone(ev));
        const dotC=allDone?"#00ff88":isToday&&hasPending?"#ff8c00":isPast&&hasPending?"#ff5555":"#ffc800";
        let bg=isToday?"rgba(var(--zos-accent-rgb),0.14)":"transparent";
        let bdr=isToday?"var(--zos-accent)":(isDarkMode?"rgba(255,255,255,0.04)":"rgba(0,0,0,0.06)");
        const cell=calGridEl.createDiv({attr:{style:`border-radius:10px;padding:5px 3px 7px;border:1px solid ${bdr};background:${bg};display:flex;flex-direction:column;align-items:center;gap:2px;min-height:54px;transition:all 0.15s;${dayEvs.length>0?"cursor:pointer;":""}`}});
        cell.createDiv({attr:{style:`font-size:0.78em;font-weight:${isToday?"800":"400"};opacity:${isPast&&!dayEvs.length?0.18:1};color:${isToday?"var(--zos-accent)":"inherit"};`}}).innerText=day;
        if(dayEvs.length>0){
            dayEvs.slice(0,2).forEach(ev=>{
                const evDone=isDone(ev),hp=getPrio(ev)==="HIGH";
                const c=evDone?"#00ff88":hp?"#b450ff":isToday?"#ff8c00":isPast?"#ff5555":"#ffc800";
                const lbl=(ev.summary||"").replace(/^Assignment:\s*/i,"").trim().slice(0,8);
                cell.createDiv({attr:{style:`font-size:0.48em;font-weight:700;padding:1px 4px;border-radius:3px;background:${c}22;color:${c};overflow:hidden;text-overflow:ellipsis;white-space:nowrap;width:100%;text-align:center;max-width:50px;${evDone?"text-decoration:line-through;opacity:0.5;":""}`}}).innerText=lbl||"•";
            });
            if(dayEvs.length>2)cell.createDiv({attr:{style:"font-size:0.46em;opacity:0.35;"}}).innerText=`+${dayEvs.length-2}`;
            cell.onmouseenter=()=>{cell.style.background=isToday?"rgba(var(--zos-accent-rgb),0.22)":(isDarkMode?"rgba(255,255,255,0.05)":"rgba(0,0,0,0.04)");cell.style.borderColor=dotC;};
            cell.onmouseleave=()=>{cell.style.background=bg;cell.style.borderColor=bdr;};
            cell.onclick=()=>{
                const showDesc=(ev)=>{
                    const ov2=document.body.createDiv({cls:"zos-modal-overlay"});
                    const moText2=modalText;
                    const moBorder2=modalBorder;
                    const mo2=ov2.createDiv({cls:"zos-modal",attr:{style:`width:460px;background:${modalBg};${modalBlur}color:${modalText};border-color:${modalBorder};box-shadow:${modalShadow};`}});
                    const title2=(ev.summary||"Untitled").replace(/^Assignment:\s*/i,"").trim();
                    const due2=getEventDate(ev),evDone=isDone(ev),dl2=due2?getDaysLeft(due2):0;
                    const u2=evDone?{acc:"#00ff88",bbg:"rgba(0,255,136,0.1)"}:urgencyStyle(dl2,getPrio(ev));
                    const cl2=()=>ov2.remove();ov2.onclick=e2=>{if(e2.target===ov2)cl2();};
                    mo2.createDiv({cls:"zos-modal-title",attr:{style:`color:${moText2};`},text:title2});
                    const meta=mo2.createDiv({attr:{style:"display:flex;align-items:center;gap:8px;flex-wrap:wrap;margin-bottom:16px;"}});
                    meta.createDiv({attr:{style:`font-size:0.72em;font-weight:700;padding:2px 9px;border-radius:10px;color:${u2.acc};background:${u2.bbg};`}}).innerText=evDone?"Submitted":due2?fmtRelative(due2):"No date";
                    meta.createDiv({attr:{style:`font-size:0.72em;font-weight:600;color:${isDarkMode?'rgba(255,255,255,0.5)':'rgba(0,0,0,0.5)'};`}}).innerText=getCalName(ev);
                    if(due2)meta.createDiv({attr:{style:`font-size:0.7em;color:${isDarkMode?'rgba(255,255,255,0.3)':'rgba(0,0,0,0.35)'};`}}).innerText=fmtDate(due2);
                    const rawDesc=(ev.description||"").replace(/https:\/\/classroom\.google\.com\/[^\s<>"\\]*/g,"").replace(/<[^>]+>/g," ").replace(/\s+/g," ").trim();
                    if(rawDesc){mo2.createDiv({attr:{style:`font-size:0.82em;line-height:1.6;background:${isDarkMode?'rgba(255,255,255,0.03)':'rgba(0,0,0,0.04)'};border-radius:10px;padding:12px;margin-bottom:16px;border:1px solid ${isDarkMode?'rgba(255,255,255,0.05)':'rgba(0,0,0,0.08)'};max-height:160px;overflow-y:auto;white-space:pre-wrap;color:${isDarkMode?'rgba(255,255,255,0.75)':'rgba(0,0,0,0.75)'};`}}).innerText=rawDesc;}
                    else{mo2.createDiv({attr:{style:`font-size:0.8em;color:${isDarkMode?'rgba(255,255,255,0.3)':'rgba(0,0,0,0.35)'};text-align:center;padding:20px;margin-bottom:16px;`}}).innerText="No description available.";}
                    const note=getNote(ev);if(note)mo2.createDiv({attr:{style:`font-size:0.75em;color:${isDarkMode?'rgba(255,255,255,0.5)':'rgba(0,0,0,0.5)'};font-style:italic;margin-bottom:14px;`}}).innerText=`✎ ${note}`;

                    // -- MATERIALS ---------------
                    const attachSection=mo2.createDiv({attr:{style:"margin-bottom:16px;"}});
                    attachSection.createDiv({attr:{style:`font-size:0.65em;font-weight:700;letter-spacing:1px;color:${isDarkMode?'rgba(255,255,255,0.35)':'rgba(0,0,0,0.4)'};margin-bottom:8px;`}}).innerText="MATERIALS";
                    const attachList=attachSection.createDiv({attr:{style:"display:flex;flex-direction:column;gap:6px;"}});
                    const aiMaterials=[];
                    attachList.createDiv({attr:{style:"font-size:0.75em;opacity:0.25;font-style:italic;"}}).innerText="Loading materials...";
                    const materialLnk=getGCRLink(ev);
                    (async()=>{
                        try{
                            const m=materialLnk?.match(/\/c\/([^/]+)\/a\/([^/]+)/);
                            if(!m){attachList.innerHTML="";attachList.createDiv({attr:{style:"font-size:0.75em;opacity:0.25;"}}).innerText="No materials link found.";return;}
                            const courseId=atob(m[1]),workId=atob(m[2]);
                            const tok=(await getWorkspaceAccessToken()).trim();
                            if(!tok){
                                attachList.innerHTML="";
                                attachList.createDiv({attr:{style:"font-size:0.75em;opacity:0.35;"}}).innerText="Google Workspace is not connected. Reconnect the plugin and try again.";
                                return;
                            }
                            const r=await fetch(`https://classroom.googleapis.com/v1/courses/${courseId}/courseWork/${workId}`,{headers:{"Authorization":`Bearer ${tok}`}});
                            if(!r.ok){
                                throw new Error(`Classroom API ${r.status}`);
                            }
                            const d=await r.json();
                            attachList.innerHTML="";
                            if(!d.materials||!d.materials.length){attachList.createDiv({attr:{style:"font-size:0.75em;opacity:0.25;font-style:italic;"}}).innerText="No materials attached.";return;}
                            d.materials.forEach(mat=>{
                                let fileTitle="",fileUrl="",fileType="";
                                let fileId="",mimeType="";
                                if(mat.driveFile){fileTitle=mat.driveFile.driveFile?.title||"Drive File";fileUrl=mat.driveFile.driveFile?.alternateLink||"";fileType=fileTitle.split(".").pop().toUpperCase()||"FILE";fileId=mat.driveFile.driveFile?.id||"";mimeType=mat.driveFile.driveFile?.mimeType||"";}
                                else if(mat.youtubeVideo){fileTitle=mat.youtubeVideo.title||"YouTube Video";fileUrl=mat.youtubeVideo.alternateLink||`https://youtu.be/${mat.youtubeVideo.id}`;fileType="VIDEO";}
                                else if(mat.link){fileTitle=mat.link.title||mat.link.url||"Link";fileUrl=mat.link.url||"";fileType="LINK";}
                                else if(mat.form){fileTitle=mat.form.title||"Form";fileUrl=mat.form.formUrl||"";fileType="FORM";}
                                if(!fileUrl)return;
                                aiMaterials.push({title:fileTitle,type:fileType,url:fileUrl,id:fileId,mimeType});
                                const typeColors={"PDF":"#ff5555","DOCX":"#00aaff","DOC":"#00aaff","PPTX":"#ff8c00","PPT":"#ff8c00","XLSX":"#00ff88","XLS":"#00ff88","VIDEO":"#b450ff","LINK":"#00e5ff","FORM":"#ffc800"};
                                const tc=typeColors[fileType]||"rgba(255,255,255,0.4)";
                                const row=attachList.createDiv({attr:{style:`display:flex;align-items:center;gap:10px;padding:9px 12px;background:${isDarkMode ? "rgba(255,255,255,0.03)" : "rgba(0,0,0,0.02)"};border-radius:10px;border:1px solid ${isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.08)"};cursor:pointer;transition:all 0.2s;`}});
                                row.createDiv({attr:{style:`font-size:0.6em;font-weight:800;padding:2px 6px;border-radius:5px;background:${tc}22;color:${tc};flex-shrink:0;`}}).innerText=fileType;
                                row.createDiv({attr:{style:"font-size:0.8em;font-weight:600;flex:1;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"}}).innerText=fileTitle;
                                row.createDiv({attr:{style:"font-size:0.75em;opacity:0.3;flex-shrink:0;"}}).innerText="↗";
                                row.onmouseenter=()=>{row.style.background=isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.04)";row.style.borderColor=`${tc}44`;};
                                row.onmouseleave=()=>{row.style.background=isDarkMode ? "rgba(255,255,255,0.03)" : "rgba(0,0,0,0.02)";row.style.borderColor=isDarkMode ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.08)";};
                                row.onclick=e3=>{e3.stopPropagation();openMaterialModal(fileTitle,fileUrl,fileType,mimeType);};
                            });
                        }catch(err){
                            attachList.innerHTML="";
                            attachList.createDiv({attr:{style:"font-size:0.75em;opacity:0.25;font-style:italic;"}}).innerText="Could not load materials.";
                        }
                    })();

                    const aiSection=mo2.createDiv({attr:{style:"margin-bottom:12px;"}});
                    const aiBtn=aiSection.createEl("button",{attr:{style:"width:100%;font-size:0.75em;font-weight:700;padding:8px;border-radius:9px;background:rgba(var(--zos-accent-rgb),0.1);color:var(--zos-accent);border:1px solid rgba(var(--zos-accent-rgb),0.24);cursor:pointer;"}});
                    aiBtn.innerText="AI Summary";
                    const aiOut=aiSection.createDiv({attr:{style:AI_SUMMARY_BOX_STYLE}});
                    aiOut.innerText="Click AI Summary to analyze description + materials.";
                    aiBtn.onclick=()=>{runAISummaryForTask(ev,rawDesc,aiMaterials,aiOut,aiBtn);};

                    const btnRow=mo2.createDiv({attr:{style:"display:flex;gap:8px;"}});
                    const lnk=getGCRLink(ev);
                    if(lnk){const ob=btnRow.createEl("button",{attr:{style:`flex:1;font-size:0.75em;font-weight:700;padding:8px;border-radius:9px;background:rgba(var(--zos-accent-rgb),0.1);color:var(--zos-accent);border:1px solid rgba(var(--zos-accent-rgb),0.2);cursor:pointer;`}});ob.innerText="↗ Open in GCR";ob.onclick=()=>{window.open(lnk,"_blank");cl2();};}
                    const db=btnRow.createEl("button",{attr:{style:`flex:1;font-size:0.75em;font-weight:700;padding:8px;border-radius:9px;background:${evDone?(isDarkMode?"rgba(255,85,85,0.12)":"rgba(220,38,38,0.08)"):(isDarkMode?"rgba(0,255,136,0.08)":"rgba(0,160,80,0.1)")};color:${evDone?(isDarkMode?"#ff5555":"#dc2626"):(isDarkMode?"#00ff88":"#00a050")};border:1px solid ${evDone?(isDarkMode?"rgba(255,85,85,0.2)":"rgba(220,38,38,0.2)"):(isDarkMode?"rgba(0,255,136,0.2)":"rgba(0,160,80,0.25)")};cursor:pointer;`}});
                    db.innerText=evDone?"↩ Undo":"✓ Done";db.onclick=()=>{toggleDone(ev);renderHeaderStats();renderSummaryBar();renderMonth();cl2();};
                    mo2.createEl("button",{cls:"zos-modal-btn zos-btn-cancel",attr:{style:`width:100%;margin-top:8px;background:${isDarkMode?'rgba(255,255,255,0.05)':'rgba(0,0,0,0.05)'};color:${moText2};border:1px solid ${moBorder2};`},text:"Close"}).onclick=cl2;
                };

                if(dayEvs.length===1){showDesc(dayEvs[0]);}
                else{
                    const ov2=document.body.createDiv({cls:"zos-modal-overlay"});
                    const mo2=ov2.createDiv({cls:"zos-modal",attr:{style:`width:420px;background:${modalBg};${modalBlur}color:${modalText};border-color:${modalBorder};box-shadow:${modalShadow};`}});
                    mo2.createDiv({cls:"zos-modal-title",attr:{style:`color:${modalText};`},text:cd.toLocaleDateString("en-US",{weekday:"long",month:"long",day:"numeric"})});
                    const cl2=()=>ov2.remove();ov2.onclick=e2=>{if(e2.target===ov2)cl2();};
                    mo2.createDiv({attr:{style:`font-size:0.72em;color:${isDarkMode?'rgba(255,255,255,0.4)':'rgba(0,0,0,0.4)'};margin-bottom:12px;`}}).innerText="Click an assignment to see its description.";
                    dayEvs.forEach(ev=>{
                        const evDone=isDone(ev),title2=(ev.summary||"").replace(/^Assignment:\s*/i,"").trim();
                        const due2=getEventDate(ev),dl2=due2?getDaysLeft(due2):0;
                        const u2=evDone?{border:"rgba(0,255,136,0.2)",bg:"rgba(0,255,136,0.04)",acc:"#00ff88",bbg:"rgba(0,255,136,0.1)"}:urgencyStyle(dl2,getPrio(ev));
                        const row=mo2.createDiv({attr:{style:`display:flex;align-items:center;gap:10px;padding:10px 12px;background:${u2.bg};border:1px solid ${u2.border};border-radius:10px;margin-bottom:7px;cursor:pointer;transition:all 0.15s;`}});
                        const info=row.createDiv({attr:{style:"flex:1;min-width:0;"}});
                        info.createDiv({attr:{style:`font-weight:700;font-size:0.85em;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;${evDone?"text-decoration:line-through;opacity:0.5;":""}`}}).innerText=(evDone?"Done: ":"")+title2;
                        info.createDiv({attr:{style:"font-size:0.68em;opacity:0.4;margin-top:2px;"}}).innerText=getCalName(ev)+(due2?` · ${fmtDate(due2)}`:"");
                        row.onmouseenter=()=>{row.style.background=isDarkMode ? "rgba(255,255,255,0.05)" : "rgba(0,0,0,0.04)";};
                        row.onmouseleave=()=>{row.style.background=u2.bg;};
                        row.onclick=()=>{cl2();showDesc(ev);};
                    });
                    mo2.createEl("button",{cls:"zos-modal-btn zos-btn-cancel",text:"Close",attr:{style:"width:100%;margin-top:4px;"}}).onclick=cl2;
                }
            };
        }
    }
}

function switchView(){
    if(!listCont||!monthCont)return;
    if(sortControlWrap) sortControlWrap.style.display=pipelineView==="list"?"flex":"none";
    if(pipelineView==="list"){listCont.style.display="block";monthCont.style.display="none";renderListView();startTimers();}
    else{listCont.style.display="none";monthCont.style.display="block";stopTimers();renderMonth();}
}

// -- DOT PULSE ANIMATION --------------
const zosStyle=document.createElement("style");
zosStyle.textContent="@keyframes zos-dot-pulse{0%,80%,100%{opacity:0.2;transform:scale(0.8)}40%{opacity:1;transform:scale(1)}}@keyframes zos-pulse{0%,100%{opacity:1}50%{opacity:0.4}}";
document.head.appendChild(zosStyle);

// -----------------------------------------------═══
//  ZEN-OS  —  Complete Setup Wizard  (drop-in replacement)
//  Paste this entire block into your dataviewjs note BEFORE the
//  renderLeftCol() / renderRightCol() / fetchAndRender() calls,
//  then replace those three lines with the boot() call at the bottom.
// -----------------------------------------------═══

// -- ACCENT PERSISTENCE (runs on every load) ---------
(function applyStoredAccent(){
    const rgb = localStorage.getItem("zos-accent-rgb");
    const hex = localStorage.getItem("zos-accent-hex");
    if(!rgb || !hex) return;
    const styleId = "zos-accent-persist";
    let el = document.getElementById(styleId);
    if(!el){ el = document.createElement("style"); el.id = styleId; document.head.appendChild(el); }
    el.textContent = `:root { --zos-accent: ${hex}; --zos-accent-rgb: ${rgb}; }`;
})();

// -- BOOT ENTRY POINT ----------------
async function saveCalFilterToVault(cals){
    try{
        const configPath="_config/zen-os-config.md";
        const file=app.vault.getAbstractFileByPath(configPath);
        if(!file)return;
        let content=await app.vault.read(file);
        const calLine="- **Selected Calendars:** "+JSON.stringify(cals);
        if(content.includes("**Selected Calendars:**")){
            content=content.replace(/- \*\*Selected Calendars:\*\*.+/,calLine);
        }else{
            content=content.replace(/(## Dashboard\n)/,"$1"+calLine+"\n");
        }
        await app.vault.modify(file,content);
    }catch(e){console.warn("ZOS: Could not save calendar filter:",e);}
}

async function loadSettingsFromVault(){
    try {
        const configPath = "_config/zen-os-config.md";
        const file = app.vault.getAbstractFileByPath(configPath);
        if(!file) return;
        const content = await app.vault.read(file);

        // Parse title
        const titleMatch = content.match(/\*\*Title:\*\*\s*(.+)/);
        if(titleMatch) localStorage.setItem("zos-banner-title", titleMatch[1].trim());

        // Parse subtitle
        const subMatch = content.match(/\*\*Subtitle:\*\*\s*(.+)/);
        if(subMatch){
            const sub = subMatch[1].trim();
            if(sub !== "(none)") localStorage.setItem("zos-banner-subtitle", sub);
        }

        // Parse accent
        const accentMatch = content.match(/\*\*Accent:\*\*\s*#([a-fA-F0-9]{6})\s*\(rgb:\s*([^)]+)\)/);
        if(accentMatch){
            localStorage.setItem("zos-accent-hex", "#" + accentMatch[1]);
            localStorage.setItem("zos-accent-rgb", accentMatch[2].trim());
        }

        // Parse selected calendars
        const calMatch = content.match(/\*\*Selected Calendars:\*\*\s*(.+)/);
        if(calMatch){
            try{
                const cals=JSON.parse(calMatch[1].trim());
                if(Array.isArray(cals)&&cals.length>0&&!(localStorage.getItem("zos-selected-calendars")||"").includes(cals[0])){
                    localStorage.setItem("zos-selected-calendars",JSON.stringify(cals));
                }
            }catch(e){}
        }

        console.log("ZOS: Settings loaded from vault ✓");
    } catch(e){
        console.warn("ZOS: Could not load settings from vault:", e);
    }
}

async function boot(){
    const flagPath = "_config/zen-os-setup-complete.md";
    let done = false;
    try {
        const flagFile = app.vault.getAbstractFileByPath(flagPath);
        done = !!flagFile;
    } catch(e){ done = false; }

    // Also sync any stored settings from vault into localStorage
    if(done) await loadSettingsFromVault();

    // Re-read after vault sync
    bannerTitle    = localStorage.getItem("zos-banner-title")    || "DASHBOARD ZEN";
    bannerSubtitle = localStorage.getItem("zos-banner-subtitle") || "";
    heroTitleEl.innerText = bannerTitle;

    if(!done){
        launchSetupWizard();
    } else {
        renderLeftCol();
        renderRightCol();
        fetchAndRender();
        fetchAINews();
        fetchGitHub();
    }
}

// -----------------------------------------------═══
//  WIZARD
// -----------------------------------------------═══
async function launchSetupWizard(){
    function getGoogleWorkspacePlugin(){
        return app?.plugins?.plugins?.["google-workspace-obsidian"];
    }

    function isGoogleWorkspacePluginEnabled(){
        return !!app?.plugins?.enabledPlugins?.has?.("google-workspace-obsidian");
    }

    function getGoogleWorkspaceApi(){
        return window.googleWorkspace || null;
    }

    function isGoogleWorkspaceConnected(){
        const gw = getGoogleWorkspaceApi();
        if(gw?.isConnected) return !!gw.isConnected();
        return !!(getGoogleWorkspacePlugin()?.auth?.isConnected?.());
    }

    function getGoogleWorkspaceEmail(){
        const gw = getGoogleWorkspaceApi();
        if(gw?.connectedEmail) return gw.connectedEmail() || "";
        return getGoogleWorkspacePlugin()?.settings?.connectedEmail || "";
    }

    // -- OVERLAY -----------------------------
    const ov = document.body.createDiv({ attr:{ style:`
        position:fixed;inset:0;z-index:99999;
        background:#08080e;
        display:flex;flex-direction:column;align-items:center;justify-content:center;
        font-family:var(--zos-font-main,'DM Sans',sans-serif);
        overflow:hidden;
    `}});

    // Ambient glows
    const glowData = [
        { top:"-180px", left:"-120px", color:"99,102,241" },
        { bottom:"-150px", right:"-100px", color:"0,255,136" },
        { top:"40%", left:"60%", color:"180,80,255", opacity:"0.04" }
    ];
    glowData.forEach(g => {
        ov.createDiv({ attr:{ style:`
            position:absolute;width:600px;height:600px;border-radius:50%;pointer-events:none;
            background:radial-gradient(circle,rgba(${g.color},${g.opacity||"0.07"}),transparent 68%);
            top:${g.top||"auto"};bottom:${g.bottom||"auto"};
            left:${g.left||"auto"};right:${g.right||"auto"};
        `}});
    });

    // -- COLLECTED STATE ---------------
    const S = {
        title:       "DASHBOARD ZEN",
        subtitle:    "",
        accentRgb:   "99,102,241",
        accentHex:   "#6366f1",
        googleOk:    isGoogleWorkspaceConnected(),
        googleEmail: "",
        aiSaved:     false,
    };



    // -- STEPS DEFINITION ---------------
    // Each step: { id, title, icon }
    const STEPS = [
        { id:"welcome",   icon:"✦",  title:"Welcome"     },
        { id:"plugin",    icon:"🔌", title:"Plugin"      },
        { id:"branding",  icon:"✏️", title:"Branding"    },
        { id:"theme",     icon:"🎨", title:"Theme"       },
        { id:"google",    icon:"🔗", title:"Google"      },
        { id:"vault",     icon:"📂", title:"Vault"       },
        { id:"ai",        icon:"🤖", title:"AI"          },
        { id:"review",    icon:"✅", title:"Review"      },
        { id:"done",      icon:"🚀", title:"Launch"      },
    ];

    let currentStep = 0;

    // -- LAYOUT ------------------------------
    const layout = ov.createDiv({ attr:{ style:`
        display:flex;width:min(900px,96vw);height:min(640px,92vh);
        background:rgba(255,255,255,0.025);
        border:1px solid rgba(255,255,255,0.08);
        border-radius:28px;
        box-shadow:0 48px 96px rgba(0,0,0,0.6);
        overflow:hidden;position:relative;z-index:1;
    `}});

    // Top shine line
    layout.createDiv({ attr:{ style:`position:absolute;top:0;left:0;right:0;height:1px;
        background:linear-gradient(90deg,transparent,rgba(255,255,255,0.12),transparent);
        pointer-events:none;z-index:2;`}});

    // -- LEFT SIDEBAR ----------------
    const sidebar = layout.createDiv({ attr:{ style:`
        width:200px;flex-shrink:0;
        background:rgba(0,0,0,0.25);
        border-right:1px solid rgba(255,255,255,0.06);
        padding:32px 0 24px;
        display:flex;flex-direction:column;
    `}});

    // Logo
    const logo = sidebar.createDiv({ attr:{ style:`
        padding:0 24px 28px;
        border-bottom:1px solid rgba(255,255,255,0.05);
        margin-bottom:20px;
    `}});
    logo.createDiv({ attr:{ style:`font-size:1.4em;font-weight:900;letter-spacing:-1px;
        background:linear-gradient(135deg,#fff,rgba(255,255,255,0.4));
        -webkit-background-clip:text;-webkit-text-fill-color:transparent;`}}).innerText = "ZEN-OS";
    logo.createDiv({ attr:{ style:"font-size:0.58em;opacity:0.3;letter-spacing:2px;margin-top:2px;font-family:monospace;"}}).innerText = "SETUP WIZARD";

    // Step list
    const stepList = sidebar.createDiv({ attr:{ style:"flex:1;display:flex;flex-direction:column;gap:2px;padding:0 10px;"}});
    const stepEls = [];

    STEPS.forEach((step, i) => {
        const el = stepList.createDiv({ attr:{ style:`
            display:flex;align-items:center;gap:10px;
            padding:9px 14px;border-radius:10px;
            font-size:0.78em;font-weight:600;
            cursor:default;transition:all 0.2s;
            color:rgba(255,255,255,0.25);
            position:relative;
        `}});
        const iconEl = el.createDiv({ attr:{ style:"font-size:1em;flex-shrink:0;width:18px;text-align:center;"}});
        iconEl.innerText = step.icon;
        el.createDiv({ text: step.title });
        stepEls.push(el);
    });

    // Version footer
    sidebar.createDiv({ attr:{ style:"padding:0 24px;font-size:0.58em;opacity:0.2;font-family:monospace;"}}).innerText = "v2.0 Professional";

    // -- RIGHT CONTENT ---------------
    const contentWrap = layout.createDiv({ attr:{ style:`
        flex:1;display:flex;flex-direction:column;min-width:0;
    `}});

    // Progress bar at top
    const progressBar = contentWrap.createDiv({ attr:{ style:`
        height:3px;background:rgba(255,255,255,0.05);flex-shrink:0;
    `}});
    const progressFill = progressBar.createDiv({ attr:{ style:`
        height:100%;background:var(--zos-accent,#6366f1);
        border-radius:0 2px 2px 0;
        transition:width 0.5s cubic-bezier(0.22,1,0.36,1);
        width:0%;
        box-shadow:0 0 8px rgba(var(--zos-accent-rgb,99,102,241),0.5);
    `}});

    // Slide area
    const slideArea = contentWrap.createDiv({ attr:{ style:`
        flex:1;overflow:hidden;position:relative;padding:44px 48px 0;
    `}});

    // Nav footer
    const navFooter = contentWrap.createDiv({ attr:{ style:`
        padding:20px 48px 28px;
        display:flex;align-items:center;justify-content:space-between;
        border-top:1px solid rgba(255,255,255,0.05);
        flex-shrink:0;
    `}});
    const backBtn = navFooter.createEl("button", { attr:{ style:`
        font-size:0.8em;font-weight:600;padding:10px 22px;border-radius:11px;
        background:transparent;color:rgba(255,255,255,0.3);
        border:1px solid rgba(255,255,255,0.08);cursor:pointer;
        transition:all 0.2s;opacity:0;pointer-events:none;
    `}});
    backBtn.innerText = "← Back";

    const rightNav = navFooter.createDiv({ attr:{ style:"display:flex;align-items:center;gap:12px;"}});
    const skipBtn = rightNav.createEl("button", { attr:{ style:`
        font-size:0.75em;font-weight:500;padding:10px 18px;border-radius:11px;
        background:transparent;color:rgba(255,255,255,0.2);
        border:1px solid transparent;cursor:pointer;
        transition:all 0.2s;display:none;
    `}});
    skipBtn.innerText = "Skip for now";
    const nextBtn = rightNav.createEl("button", { attr:{ style:`
        font-size:0.85em;font-weight:700;padding:12px 30px;border-radius:11px;
        background:var(--zos-accent,#6366f1);color:#fff;border:none;cursor:pointer;
        transition:all 0.25s cubic-bezier(0.22,1,0.36,1);letter-spacing:0.3px;
        box-shadow:0 4px 20px rgba(var(--zos-accent-rgb,99,102,241),0.4);
    `}});
    nextBtn.innerText = "Get Started →";

    // -- HOVER STATES ----------------
    backBtn.onmouseenter=()=>{ backBtn.style.color="rgba(255,255,255,0.65)"; backBtn.style.borderColor="rgba(255,255,255,0.15)"; };
    backBtn.onmouseleave=()=>{ backBtn.style.color="rgba(255,255,255,0.3)"; backBtn.style.borderColor="rgba(255,255,255,0.08)"; };
    skipBtn.onmouseenter=()=>{ skipBtn.style.color="rgba(255,255,255,0.5)"; };
    skipBtn.onmouseleave=()=>{ skipBtn.style.color="rgba(255,255,255,0.2)"; };
    nextBtn.onmouseenter=()=>{ nextBtn.style.transform="translateY(-2px)"; nextBtn.style.boxShadow="0 8px 28px rgba(var(--zos-accent-rgb,99,102,241),0.55)"; };
    nextBtn.onmouseleave=()=>{ nextBtn.style.transform=""; nextBtn.style.boxShadow="0 4px 20px rgba(var(--zos-accent-rgb,99,102,241),0.4)"; };

    // -- UPDATE SIDEBAR ----------------
    function updateSidebar(step){
        stepEls.forEach((el, i) => {
            if(i < step){
                el.style.color = "rgba(0,255,136,0.6)";
                el.style.background = "transparent";
                el.querySelector("div").innerText = "✓";
            } else if(i === step){
                el.style.color = "#fff";
                el.style.background = "rgba(var(--zos-accent-rgb,99,102,241),0.12)";
                el.querySelector("div").innerText = STEPS[i].icon;
            } else {
                el.style.color = "rgba(255,255,255,0.25)";
                el.style.background = "transparent";
                el.querySelector("div").innerText = STEPS[i].icon;
            }
        });
        const pct = (step / (STEPS.length - 1)) * 100;
        progressFill.style.width = `${pct}%`;
    }

    // -- SLIDE TRANSITION --------------
    function slideIn(el, dir=1){
        el.style.opacity = "0";
        el.style.transform = `translateX(${dir * 36}px)`;
        el.style.transition = "none";
        requestAnimationFrame(()=>{
            requestAnimationFrame(()=>{
                el.style.transition = "opacity 0.38s ease, transform 0.38s cubic-bezier(0.22,1,0.36,1)";
                el.style.opacity = "1";
                el.style.transform = "translateX(0)";
            });
        });
    }

    // -- HELPERS -----------------------------
    function mkHeading(parent, title, sub){
        parent.createDiv({ attr:{ style:`font-size:1.75em;font-weight:800;letter-spacing:-0.5px;
            margin-bottom:${sub?'6px':'24px'};line-height:1.1;`}}).innerText = title;
        if(sub) parent.createDiv({ attr:{ style:"opacity:0.4;font-size:0.85em;margin-bottom:22px;line-height:1.6;"}}).innerText = sub;
    }

    function mkLabel(parent, text){
        parent.createDiv({ attr:{ style:`font-size:0.6em;font-weight:700;letter-spacing:2px;
            opacity:0.35;text-transform:uppercase;margin-bottom:7px;font-family:monospace;`}}).innerText = text;
    }

    function mkInput(parent, {placeholder="", value="", type="text", onInput}={}){
        const inp = parent.createEl("input", { attr:{
            type, placeholder, value,
            style:`width:100%;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);
                border-radius:11px;padding:13px 15px;color:#fff;font-size:0.88em;
                outline:none;box-sizing:border-box;font-family:inherit;
                transition:border-color 0.2s,background 0.2s;margin-bottom:14px;`
        }});
        inp.onfocus=()=>{ inp.style.borderColor="var(--zos-accent,#6366f1)"; inp.style.background="rgba(var(--zos-accent-rgb,99,102,241),0.06)"; };
        inp.onblur=()=>{ inp.style.borderColor="rgba(255,255,255,0.1)"; inp.style.background="rgba(255,255,255,0.05)"; };
        if(onInput) inp.oninput=()=>onInput(inp.value);
        return inp;
    }

    function statusBadge(parent, {text, color="#00ff88", bg}={}){
        const badge = parent.createDiv({ attr:{ style:`
            display:inline-flex;align-items:center;gap:8px;
            padding:10px 14px;border-radius:11px;
            background:${bg||color+'14'};
            border:1px solid ${color}33;
            font-size:0.8em;font-weight:600;color:${color};
        `}});
        badge.createDiv({ attr:{ style:`width:8px;height:8px;border-radius:50%;
            background:${color};box-shadow:0 0 8px ${color}99;flex-shrink:0;`}});
        badge.createDiv({ text });
        return badge;
    }

    // validateAIKey is defined in global scope above

    // -- SAVE ACCENT CSS SNIPPET TO VAULT ----------
    async function saveAccentSnippet(rgb, hex){
        try {
            const snippetContent = `/* ZEN-OS Accent Color — auto-generated by Setup Wizard */\n:root {\n    --zos-accent: ${hex};\n    --zos-accent-rgb: ${rgb};\n}\n`;
            const snippetPath = ".obsidian/snippets/zen-os-accent.css";
            const existing = app.vault.getAbstractFileByPath(snippetPath);
            if(existing){ await app.vault.modify(existing, snippetContent); }
            else { await app.vault.create(snippetPath, snippetContent); }
            // Enable the snippet
            try {
                const customCssPlugin = app.customCss;
                if(customCssPlugin){
                    const snippets = customCssPlugin.enabledSnippets || new Set();
                    snippets.add("zen-os-accent");
                    await customCssPlugin.setCssEnabledStatus?.("zen-os-accent", true);
                    await customCssPlugin.loadCss?.();
                }
            } catch(e){}
            return true;
        } catch(e){ console.warn("ZOS Wizard: Could not save accent snippet:", e); return false; }
    }

    // -- SAVE CONFIG NOTE --------------
    async function saveConfigNote(){
        try {
            const configDir = "_config";
            if(!app.vault.getAbstractFileByPath(configDir)){
                await app.vault.createFolder(configDir);
            }
            const content = [
                "# ZEN-OS Configuration",
                "",
                `> Auto-generated by Setup Wizard on ${new Date().toLocaleDateString()}`,
                "",
                "## Dashboard",
                `- **Title:** ${S.title}`,
                `- **Subtitle:** ${S.subtitle||"(none)"}`,
                `- **Accent:** ${S.accentHex} (rgb: ${S.accentRgb})`,
                "",
                "## Integrations",
                `- **Google:** ${S.googleOk ? "✅ Connected" : "⚠️ Not connected"}`,
                `- **AI:** ${S.aiSaved ? "✅ Key saved" : "⚠️ No key saved"}`,
                "",
                "## Notes",
                "- To re-run setup wizard, delete the file: `_config/zen-os-setup-complete.md`",
                "- AI keys are stored in browser localStorage (never in this file)",
            ].join("\n");
            const path = "_config/zen-os-config.md";
            const existing = app.vault.getAbstractFileByPath(path);
            if(existing){ await app.vault.modify(existing, content); }
            else { await app.vault.create(path, content); }

            // Write the completion flag file
            const flagPath = "_config/zen-os-setup-complete.md";
            const flagContent = `# ZEN-OS Setup Complete\n\nSetup completed on: ${new Date().toLocaleString()}\n\nDo not delete this file — it tells ZEN-OS that setup has already been done.\nTo re-run the setup wizard, delete this file and reload the dashboard.\n`;
            const existingFlag = app.vault.getAbstractFileByPath(flagPath);
            if(existingFlag){ await app.vault.modify(existingFlag, flagContent); }
            else { await app.vault.create(flagPath, flagContent); }
        } catch(e){ console.warn("ZOS Wizard: Could not save config note:", e); }
    }

    // ══════════════════════════════════════════════════════════════
    //  STEP RENDERERS
    // ══════════════════════════════════════════════════════════════
    const stepRenderers = {

        // -- WELCOME -----------------
        welcome(body){
            body.style.display = "flex";
            body.style.flexDirection = "column";
            body.style.alignItems = "center";
            body.style.textAlign = "center";

            body.createDiv({ attr:{ style:`font-size:3.5em;margin-bottom:14px;
                filter:drop-shadow(0 0 20px rgba(var(--zos-accent-rgb,99,102,241),0.5));`}}).innerText = "✦";
            body.createDiv({ attr:{ style:`font-size:2em;font-weight:900;letter-spacing:-1.5px;margin-bottom:10px;
                background:linear-gradient(135deg,#fff 0%,rgba(255,255,255,0.45) 100%);
                -webkit-background-clip:text;-webkit-text-fill-color:transparent;`}}).innerText = "Welcome to ZEN-OS";
            body.createDiv({ attr:{ style:"opacity:0.45;font-size:0.88em;line-height:1.75;max-width:380px;margin-bottom:32px;"}})
                .innerText = "Your all-in-one Obsidian command center.\nThis wizard will set everything up from scratch — Google Classroom, AI assistant, themes, and more.";

            const grid = body.createDiv({ attr:{ style:"display:grid;grid-template-columns:1fr 1fr;gap:10px;width:100%;max-width:420px;"}});
            [
                { i:"📅", t:"Assignment sync",   d:"Google Classroom" },
                { i:"🤖", t:"AI assistant",       d:"5 providers" },
                { i:"🏴‍☠️", t:"CTF tracker",       d:"Live events" },
                { i:"🎨", t:"Custom theming",     d:"8 accent colors" },
            ].forEach(f => {
                const chip = grid.createDiv({ attr:{ style:`
                    display:flex;align-items:center;gap:10px;padding:13px 14px;
                    background:rgba(255,255,255,0.04);border-radius:12px;
                    border:1px solid rgba(255,255,255,0.07);text-align:left;
                `}});
                chip.createDiv({ attr:{ style:"font-size:1.3em;flex-shrink:0;"}}).innerText = f.i;
                const info = chip.createDiv();
                info.createDiv({ attr:{ style:"font-size:0.8em;font-weight:700;"}}).innerText = f.t;
                info.createDiv({ attr:{ style:"font-size:0.65em;opacity:0.35;margin-top:1px;"}}).innerText = f.d;
            });

            body.createDiv({ attr:{ style:"font-size:0.7em;opacity:0.2;margin-top:auto;padding-top:16px;"}})
                .innerText = "Takes about 2 minutes · Everything can be changed later";
        },

        // -- PLUGIN CHECK --------------
        plugin(body){
            mkHeading(body, "Google Workspace plugin", "ZEN-OS needs this plugin to sync Calendar, Classroom, and Drive.");

            const gwPlugin = getGoogleWorkspacePlugin();
            const isInstalled = !!gwPlugin;
            const isEnabled   = !!(gwPlugin && isGoogleWorkspacePluginEnabled());

            const statusWrap = body.createDiv({ attr:{ style:"margin-bottom:24px;"}});
            if(isInstalled && isEnabled){
                statusBadge(statusWrap, { text:"Google Workspace plugin — installed & enabled ✓", color:"#00ff88" });
                body.createDiv({ attr:{ style:"font-size:0.82em;opacity:0.5;margin-top:12px;line-height:1.6;"}})
                    .innerText = "You're all set. Continue to the next step.";
            } else {
                statusBadge(statusWrap, { text: isInstalled ? "Plugin installed but not enabled" : "Plugin not detected", color:"#ffc800" });

                body.createDiv({ attr:{ style:"font-size:0.82em;opacity:0.55;line-height:1.7;margin-bottom:20px;"}})
                    .innerText = isInstalled
                        ? "The plugin is installed but not enabled. Enable it in Obsidian Settings → Community Plugins."
                        : "Install the Google Calendar community plugin. It takes 30 seconds.";

                // Steps
                const steps = isInstalled
                    ? ["Open Settings (Cmd/Ctrl + ,)", "Go to Community Plugins", "Find Google Workspace → Enable it"]
                    : ["Open Settings (Cmd/Ctrl + ,)", "Go to Community Plugins → Browse", "Search \"Google Workspace\"", "Install & Enable it"];

                steps.forEach((s, i) => {
                    const row = body.createDiv({ attr:{ style:`
                        display:flex;align-items:center;gap:12px;padding:10px 14px;
                        background:rgba(255,255,255,0.03);border-radius:10px;
                        border:1px solid rgba(255,255,255,0.06);margin-bottom:7px;
                        font-size:0.82em;
                    `}});
                    row.createDiv({ attr:{ style:`width:22px;height:22px;border-radius:50%;flex-shrink:0;
                        background:rgba(var(--zos-accent-rgb,99,102,241),0.15);
                        color:var(--zos-accent,#6366f1);font-size:0.7em;font-weight:800;
                        display:flex;align-items:center;justify-content:center;`}}).innerText = String(i+1);
                    row.createDiv().innerText = s;
                });

                // Deep link button
                const deepLinkBtn = body.createEl("button", { attr:{ style:`
    display:flex;align-items:center;justify-content:center;gap:8px;
    width:100%;margin-top:14px;padding:12px;border-radius:12px;
    background:rgba(var(--zos-accent-rgb,99,102,241),0.12);
    color:var(--zos-accent,#6366f1);
    border:1px solid rgba(var(--zos-accent-rgb,99,102,241),0.25);
    cursor:pointer;font-size:0.85em;font-weight:700;transition:all 0.2s;
`}});
deepLinkBtn.innerHTML = "⚙ Open Settings (minimizes wizard)";
deepLinkBtn.onmouseenter=()=>{ deepLinkBtn.style.background="rgba(var(--zos-accent-rgb,99,102,241),0.2)"; };
deepLinkBtn.onmouseleave=()=>{ deepLinkBtn.style.background="rgba(var(--zos-accent-rgb,99,102,241),0.12)"; };
deepLinkBtn.onclick=()=>{
    // Minimize wizard to a floating pill so user can access settings
    layout.style.display = "none";
    ov.style.background = "transparent";
    ov.style.pointerEvents = "none";

    const pill = ov.createDiv({ attr:{ style:`
        position:fixed;bottom:24px;right:24px;
        background:rgba(10,10,20,0.95);
        border:1px solid rgba(var(--zos-accent-rgb,99,102,241),0.4);
        border-radius:50px;padding:10px 20px;
        display:flex;align-items:center;gap:10px;
        font-size:0.8em;font-weight:700;color:var(--zos-accent,#6366f1);
        cursor:pointer;z-index:999999;pointer-events:auto;
        box-shadow:0 8px 32px rgba(0,0,0,0.6);
        backdrop-filter:blur(20px);
        animation:zos-pulse 2s ease-in-out infinite;
    `}});
    pill.innerHTML = `<span style="font-size:1.2em;">✦</span> Return to ZEN-OS Setup`;
    pill.onclick=()=>{
        pill.remove();
        layout.style.display = "";
        ov.style.background = "";
        ov.style.pointerEvents = "";
        // Re-check plugin status when returning
        renderStep(currentStep, 0);
    };
}
                // Check again button
                const checkBtn = body.createEl("button", { attr:{ style:`
                    display:flex;align-items:center;justify-content:center;gap:8px;
                    width:100%;margin-top:8px;padding:10px;border-radius:12px;
                    background:rgba(255,255,255,0.04);color:rgba(255,255,255,0.45);
                    border:1px solid rgba(255,255,255,0.08);
                    cursor:pointer;font-size:0.8em;font-weight:600;transition:all 0.2s;
                `}});
                checkBtn.innerText = "↺ I installed it — check again";
                checkBtn.onclick=()=>{
                    const gw2 = getGoogleWorkspacePlugin();
                    if(gw2){ renderStep(currentStep, 0); }
                    else { checkBtn.innerText = "Still not detected — try restarting Obsidian"; checkBtn.style.color="#ff5555"; }
                };
            }
        },

        // -- BRANDING ----------------
        branding(body){
            mkHeading(body, "Name your dashboard", "Give it a title and tagline that motivates you.");

            mkLabel(body, "Dashboard Title");
            const titleInp = mkInput(body, { placeholder:"e.g. MY COMMAND CENTER", value:S.title, onInput: v => {
                S.title = v.trim().toUpperCase() || "DASHBOARD ZEN";
                prevTitle.innerText = S.title;
            }});
            titleInp.style.fontFamily = "var(--zos-font-head,'Syne',sans-serif)";
            titleInp.style.fontWeight = "700";

            mkLabel(body, "Tagline / Subtitle");
            const subInp = mkInput(body, { placeholder:"e.g. Focus. Build. Ship.", value:S.subtitle, onInput: v => {
                S.subtitle = v;
                prevSub.innerText = v || "Your tagline here";
            }});

            // Live preview card
            const preview = body.createDiv({ attr:{ style:`
                margin-top:8px;padding:20px 24px;
                background:rgba(255,255,255,0.03);
                border:1px solid rgba(255,255,255,0.07);
                border-radius:14px;position:relative;overflow:hidden;
            `}});
            preview.createDiv({ attr:{ style:`position:absolute;top:0;left:0;right:0;height:2px;
                background:linear-gradient(90deg,var(--zos-accent,#6366f1),transparent);`}});
            preview.createDiv({ attr:{ style:"font-size:0.6em;opacity:0.3;letter-spacing:2px;margin-bottom:8px;font-family:monospace;"}}).innerText = "PREVIEW";
            const prevTitle = preview.createDiv({ attr:{ style:`font-size:1.6em;font-weight:900;letter-spacing:-1px;
                background:linear-gradient(135deg,#fff,rgba(255,255,255,0.45));
                -webkit-background-clip:text;-webkit-text-fill-color:transparent;`}});
            prevTitle.innerText = S.title;
            const prevSub = preview.createDiv({ attr:{ style:"font-size:0.75em;opacity:0.35;margin-top:3px;"}});
            prevSub.innerText = S.subtitle || "Your tagline here";
        },

        // -- THEME -----------------
        theme(body){
            mkHeading(body, "Choose your accent color", "Used for highlights, buttons, and glows across the entire dashboard.");

            const colorGrid = body.createDiv({ attr:{ style:"display:grid;grid-template-columns:repeat(4,1fr);gap:10px;margin-bottom:20px;"}});

            ACCENTS.forEach(p => {
                const isSelected = p.rgb === S.accentRgb;
                const btn = colorGrid.createEl("button", { attr:{ style:`
                    display:flex;flex-direction:column;align-items:center;gap:9px;
                    padding:16px 10px;border-radius:14px;cursor:pointer;
                    background:${isSelected ? "rgba(255,255,255,0.07)" : "rgba(255,255,255,0.03)"};
                    border:2px solid ${isSelected ? p.hex : "rgba(255,255,255,0.07)"};
                    transition:all 0.2s;
                `}});

                const swatch = btn.createDiv({ attr:{ style:`
                    width:34px;height:34px;border-radius:50%;
                    background:${p.hex};
                    box-shadow:${isSelected ? `0 0 20px ${p.hex}88` : "none"};
                    transition:box-shadow 0.2s;
                `}});
                if(isSelected) swatch.createDiv({ attr:{ style:`
                    width:100%;height:100%;border-radius:50%;
                    display:flex;align-items:center;justify-content:center;
                    color:#000;font-size:0.9em;font-weight:800;
                `}}).innerText = "✓";

                btn.createDiv({ attr:{ style:"font-size:0.65em;font-weight:700;opacity:0.7;"}}).innerText = p.label;

                btn.onclick = () => {
                    S.accentRgb = p.rgb;
                    S.accentHex = p.hex;
                    // Update CSS live
                    document.documentElement.style.setProperty("--zos-accent", p.hex);
                    document.documentElement.style.setProperty("--zos-accent-rgb", p.rgb);
                    const liveStyle = document.getElementById("zos-accent-persist") || document.createElement("style");
                    liveStyle.id = "zos-accent-persist";
                    liveStyle.textContent = `:root { --zos-accent: ${p.hex}; --zos-accent-rgb: ${p.rgb}; }`;
                    document.head.appendChild(liveStyle);
                    // Update next button color
                    nextBtn.style.background = p.hex;
                    // Re-render grid
                    colorGrid.querySelectorAll("button").forEach((b, bi) => {
                        const bp = ACCENTS[bi];
                        const sel = bp.rgb === p.rgb;
                        b.style.borderColor = sel ? bp.hex : "rgba(255,255,255,0.07)";
                        b.style.background = sel ? "rgba(255,255,255,0.07)" : "rgba(255,255,255,0.03)";
                    });
                };
                btn.onmouseenter=()=>{ if(p.rgb!==S.accentRgb){ btn.style.borderColor=`${p.hex}55`; btn.style.background="rgba(255,255,255,0.05)"; } };
                btn.onmouseleave=()=>{ if(p.rgb!==S.accentRgb){ btn.style.borderColor="rgba(255,255,255,0.07)"; btn.style.background="rgba(255,255,255,0.03)"; } };
            });

            // Live preview bar
            body.createDiv({ attr:{ style:`height:5px;border-radius:4px;
                background:var(--zos-accent,#6366f1);
                box-shadow:0 0 16px rgba(var(--zos-accent-rgb,99,102,241),0.5);
                transition:all 0.3s ease;`}});
            body.createDiv({ attr:{ style:"font-size:0.7em;opacity:0.25;margin-top:8px;text-align:center;"}})
                .innerText = "The accent color will also be saved as a CSS snippet in your vault.";
        },

        // -- GOOGLE ----------------
        google(body){
            mkHeading(body, "Connect Google Workspace", "ZEN-OS uses your Google Workspace plugin connection directly. Sign in once and all data syncs through the plugin.");

            const plugin = getGoogleWorkspacePlugin();
            const gwApi = getGoogleWorkspaceApi();
            const existingConnected = isGoogleWorkspaceConnected();
            const statusWrap  = body.createDiv({ attr:{ style:"margin-bottom:18px;" }});
            const connectArea = body.createDiv({ attr:{ style:"margin-bottom:10px;" }});
            const stepsWrap   = body.createDiv();
            const bottomWrap  = body.createDiv({ attr:{ style:"margin-top:14px;" }});

            const renderConnected = async () => {
                statusWrap.innerHTML = "";
                connectArea.innerHTML = "";
                stepsWrap.innerHTML  = "";
                bottomWrap.innerHTML = "";
                S.googleOk = true;
                S.googleEmail = getGoogleWorkspaceEmail();

                statusBadge(statusWrap, {
                    text: S.googleEmail ? `Connected as ${S.googleEmail} ✓` : "Google Workspace connected ✓",
                    color: "#00ff88"
                });
                stepsWrap.createDiv({ attr:{ style:"font-size:0.82em;opacity:0.45;line-height:1.7;margin-top:10px;" }})
                    .innerText = "Your assignments will sync automatically. Continue to the next step.";

                const reBtn = bottomWrap.createEl("button", { attr:{ style:`
                    font-size:0.72em;opacity:0.3;padding:8px 14px;border-radius:9px;
                    background:transparent;border:1px dashed rgba(255,255,255,0.1);
                    color:#fff;cursor:pointer;transition:opacity 0.2s;
                `}});
                reBtn.innerText = "↺ Reconnect with a different account";
                reBtn.onmouseenter = () => { reBtn.style.opacity = "0.7"; };
                reBtn.onmouseleave = () => { reBtn.style.opacity = "0.3"; };
                reBtn.onclick = async () => {
                    try { await plugin?.auth?.logout?.(); } catch(e){}
                    S.googleOk = false;
                    S.googleEmail = "";
                    renderNotConnected();
                };
            };

            const renderNotConnected = () => {
                statusWrap.innerHTML = "";
                connectArea.innerHTML = "";
                stepsWrap.innerHTML  = "";
                bottomWrap.innerHTML = "";

                statusBadge(statusWrap, { text:"Not connected yet", color:"rgba(255,255,255,0.35)", bg:"rgba(255,255,255,0.04)" });

                if(!plugin || !isGoogleWorkspacePluginEnabled()){
                    stepsWrap.createDiv({ attr:{ style:"font-size:0.82em;opacity:0.55;line-height:1.7;margin-bottom:14px;" }})
                        .innerText = "Install and enable the Google Workspace plugin first, then return and connect your account.";
                }

                const connectBtn = connectArea.createEl("button", { attr:{ style:`
                    display:flex;align-items:center;justify-content:center;gap:10px;
                    width:100%;padding:14px;border-radius:13px;
                    background:rgba(var(--zos-accent-rgb,99,102,241),0.12);
                    color:var(--zos-accent,#6366f1);
                    border:1px solid rgba(var(--zos-accent-rgb,99,102,241),0.25);
                    cursor:pointer;font-size:0.88em;font-weight:700;
                    transition:all 0.2s;margin-bottom:10px;
                `}});
                connectBtn.innerHTML = `<span style="font-size:1.2em;">🔗</span> Sign in with Google`;
                connectBtn.onmouseenter=()=>{ connectBtn.style.background="rgba(var(--zos-accent-rgb,99,102,241),0.22)"; };
                connectBtn.onmouseleave=()=>{ connectBtn.style.background="rgba(var(--zos-accent-rgb,99,102,241),0.12)"; };

                connectBtn.onclick = async () => {
                    if(!plugin || !isGoogleWorkspacePluginEnabled()){
                        connectBtn.innerText = "⚠ Google Workspace plugin is not enabled";
                        connectBtn.style.color = "#ff5555";
                        return;
                    }

                    connectBtn.innerHTML = `<span style="display:inline-flex;gap:3px;align-items:center;">
                        <span style="animation:zos-dot-pulse 1.2s 0s infinite">●</span>
                        <span style="animation:zos-dot-pulse 1.2s 0.2s infinite">●</span>
                        <span style="animation:zos-dot-pulse 1.2s 0.4s infinite">●</span>
                    </span> Opening plugin sign-in...`;
                    connectBtn.style.pointerEvents = "none";

                    try {
                        if(plugin?.auth?.login){
                            await plugin.auth.login();
                        } else {
                            throw new Error("Plugin auth API unavailable");
                        }

                        let attempts = 0;
                        const poll = setInterval(async () => {
                            attempts++;
                            if(isGoogleWorkspaceConnected()){
                                clearInterval(poll);
                                S.googleOk = true;
                                await renderConnected();
                            } else if(attempts >= 180){
                                clearInterval(poll);
                            }
                        }, 1000);

                    } catch(e) {
                        connectBtn.innerText = `⚠ Sign-in failed: ${String(e.message||e).slice(0,70)}`;
                        connectBtn.style.color = "#ff5555";
                    } finally {
                        connectBtn.style.pointerEvents = "";
                    }
                };

                // Step-by-step guide
                const steps = [
                    {
                        n: "1",
                        title: "Install the Google Workspace plugin",
                        desc: "Open Obsidian Settings → Community Plugins → Browse → search \"Google Workspace\" → Install & Enable.",
                        btn: { label:"⚙ Open Plugin Settings", action: () => {
    try {
        app.setting.open();
        app.setting.openTabById("google-workspace-obsidian");
    } catch(e) {
        // fallback — just open settings
        try { app.setting.open(); } catch(e2) {}
    }
}}
                    },
                    {
                        n: "2",
                        title: "Connect your Google account",
                        desc: "Click the sign-in button above, or use the plugin settings and click \"Connect Google Account\".",
                        btn: null
                    },
                    {
                        n: "3",
                        title: "Come back here and click Check Connection",
                        desc: "Once signed in, ZEN-OS reads connection status directly from the Google Workspace plugin.",
                        btn: null
                    },
                ];

                steps.forEach(s => {
                    const row = stepsWrap.createDiv({ attr:{ style:`
                        display:flex;align-items:flex-start;gap:14px;padding:12px 14px;
                        background:rgba(255,255,255,0.03);border-radius:12px;
                        border:1px solid rgba(255,255,255,0.06);margin-bottom:8px;
                    `}});
                    row.createDiv({ attr:{ style:`
                        width:26px;height:26px;border-radius:50%;flex-shrink:0;
                        background:rgba(var(--zos-accent-rgb,99,102,241),0.15);
                        color:var(--zos-accent,#6366f1);font-size:0.7em;font-weight:800;
                        display:flex;align-items:center;justify-content:center;margin-top:1px;
                    `}}).innerText = s.n;
                    const info = row.createDiv({ attr:{ style:"flex:1;min-width:0;" }});
                    info.createDiv({ attr:{ style:"font-size:0.83em;font-weight:700;margin-bottom:3px;" }}).innerText = s.title;
                    info.createDiv({ attr:{ style:"font-size:0.75em;opacity:0.45;line-height:1.55;" }}).innerText = s.desc;
                    if(s.btn){
                        const b = info.createEl("button", { attr:{ style:`
                            margin-top:8px;font-size:0.72em;font-weight:700;padding:6px 14px;
                            border-radius:8px;background:rgba(var(--zos-accent-rgb,99,102,241),0.12);
                            color:var(--zos-accent,#6366f1);border:1px solid rgba(var(--zos-accent-rgb,99,102,241),0.25);
                            cursor:pointer;transition:all 0.2s;
                        `}});
                        b.innerText = s.btn.label;
                        b.onclick = s.btn.action;
                    }
                });

                // Check connection button
                const checkBtn = bottomWrap.createEl("button", { attr:{ style:`
                    display:flex;align-items:center;justify-content:center;gap:8px;
                    width:100%;padding:13px;border-radius:12px;margin-top:4px;
                    background:rgba(var(--zos-accent-rgb,99,102,241),0.12);
                    color:var(--zos-accent,#6366f1);
                    border:1px solid rgba(var(--zos-accent-rgb,99,102,241),0.25);
                    cursor:pointer;font-size:0.85em;font-weight:700;transition:all 0.2s;
                `}});
                checkBtn.innerText = "↺  Check Connection";
                checkBtn.onmouseenter = () => { checkBtn.style.background = "rgba(var(--zos-accent-rgb,99,102,241),0.22)"; };
                checkBtn.onmouseleave = () => { checkBtn.style.background = "rgba(var(--zos-accent-rgb,99,102,241),0.12)"; };
                checkBtn.onclick = async () => {
                    if(isGoogleWorkspaceConnected()){
                        await renderConnected();
                    } else {
                        checkBtn.innerText = "Still not detected — make sure you signed in to the plugin";
                        checkBtn.style.color = "#ff8c00";
                        checkBtn.style.borderColor = "rgba(255,140,0,0.3)";
                        setTimeout(() => {
                            checkBtn.innerText = "↺  Check Connection";
                            checkBtn.style.color = "";
                            checkBtn.style.borderColor = "";
                        }, 3000);
                    }
                };
            };

            // Initial render
            if(existingConnected){ renderConnected(); }
            else { renderNotConnected(); }
        },

        // -- VAULT ACCESS --------------
        vault(body){
            mkHeading(body, "Vault access", "ZEN-OS reads your notes for AI-powered search and context. Here's exactly what it accesses.");

            const perms = [
                { icon:"📖", title:"Read notes",        desc:"Searches your markdown files for relevant context when you ask the AI assistant questions.", level:"Read only" },
                { icon:"✏️",  title:"Create notes",      desc:"Can create new notes when you ask the AI to (e.g. 'Create a note for this assignment').", level:"Optional" },
                { icon:"📁",  title:"List folders",      desc:"Browses your folder structure so you can choose where to save new notes.", level:"Read only" },
                { icon:"🔑",  title:"CSS snippets",      desc:"Writes one snippet file to .obsidian/snippets/ to persist your accent color across restarts.", level:"One-time write" },
                { icon:"⚙️",  title:"Config note",       desc:"Creates _config/zen-os-config.md with your settings summary (no API keys stored here).", level:"One-time write" },
            ];

            perms.forEach(p => {
                const row = body.createDiv({ attr:{ style:`
                    display:flex;align-items:flex-start;gap:14px;padding:12px 14px;
                    background:rgba(255,255,255,0.03);border-radius:12px;
                    border:1px solid rgba(255,255,255,0.06);margin-bottom:8px;
                `}});
                row.createDiv({ attr:{ style:"font-size:1.3em;flex-shrink:0;margin-top:1px;"}}).innerText = p.icon;
                const info = row.createDiv({ attr:{ style:"flex:1;min-width:0;"}});
                const titleRow = info.createDiv({ attr:{ style:"display:flex;align-items:center;gap:8px;margin-bottom:3px;"}});
                titleRow.createDiv({ attr:{ style:"font-size:0.83em;font-weight:700;"}}).innerText = p.title;
                titleRow.createDiv({ attr:{ style:`
                    font-size:0.58em;font-weight:700;padding:2px 7px;border-radius:6px;
                    background:rgba(var(--zos-accent-rgb,99,102,241),0.1);
                    color:var(--zos-accent,#6366f1);
                `}}).innerText = p.level;
                info.createDiv({ attr:{ style:"font-size:0.75em;opacity:0.4;line-height:1.5;"}}).innerText = p.desc;
            });

            body.createDiv({ attr:{ style:`
                font-size:0.72em;opacity:0.25;margin-top:12px;text-align:center;line-height:1.6;
                padding:10px;background:rgba(255,255,255,0.02);border-radius:8px;
                border:1px solid rgba(255,255,255,0.04);
            `}}).innerText = "🔒 API keys are stored only in browser localStorage — never written to any file in your vault.";
        },

        // -- AI ------------------------------
        ai(body){
            mkHeading(body, "Connect an AI provider", "Powers your assistant, summaries, and auto-fill. At least one free option recommended.");

            const existingProvider = AI_PROVIDERS.find(p => (localStorage.getItem(p.id)||"").trim().length > 8);
            if(existingProvider){
                const banner = body.createDiv({ attr:{ style:"margin-bottom:16px;"}});
                statusBadge(banner, { text:`${existingProvider.label} key already saved ✓ — you can add more or continue`, color:"#00ff88" });
            }

            const providerList = body.createDiv({ attr:{ style:"display:flex;flex-direction:column;gap:8px;max-height:300px;overflow-y:auto;padding-right:4px;"}});

            AI_PROVIDERS.forEach(p => {
                const existing = (localStorage.getItem(p.id)||"").trim();
                const hasKey = existing.length > 8;

                const card = providerList.createDiv({ attr:{ style:`
                    border-radius:12px;border:1px solid ${hasKey?"rgba(0,255,136,0.2)":"rgba(255,255,255,0.07)"};
                    background:${hasKey?"rgba(0,255,136,0.04)":"rgba(255,255,255,0.03)"};
                    overflow:hidden;transition:all 0.2s;
                `}});

                const header = card.createDiv({ attr:{ style:`
                    display:flex;align-items:center;gap:10px;padding:11px 14px;cursor:pointer;
                `}});

                const statusDot = header.createDiv({ attr:{ style:`
                    width:8px;height:8px;border-radius:50%;flex-shrink:0;
                    background:${hasKey?"#00ff88":"rgba(255,255,255,0.15)"};
                    box-shadow:${hasKey?"0 0 6px rgba(0,255,136,0.5)":"none"};
                    transition:all 0.3s;
                `}});
                header.createDiv({ attr:{ style:"font-size:0.85em;font-weight:700;flex:1;"}}).innerText = p.label;
                if(p.free) header.createDiv({ attr:{ style:`font-size:0.58em;font-weight:700;padding:2px 6px;
                    border-radius:5px;background:rgba(0,255,136,0.1);color:#00ff88;`}}).innerText = "FREE";
                header.createDiv({ attr:{ style:`font-size:0.6em;opacity:0.3;padding:2px 7px;border-radius:5px;
                    background:rgba(255,255,255,0.05);`}}).innerText = p.badge;

                const validationEl = header.createDiv({ attr:{ style:"font-size:0.65em;font-family:monospace;flex-shrink:0;"}});
                if(hasKey) validationEl.innerText = "✓ saved";

                const expandArea = card.createDiv({ attr:{ style:"display:none;padding:0 14px 14px;border-top:1px solid rgba(255,255,255,0.05);padding-top:12px;"}});

                // Toggle expand
                let expanded = !hasKey && p === AI_PROVIDERS[0]; // auto-expand first
                expandArea.style.display = expanded ? "block" : "none";
                header.onclick = () => {
                    expanded = !expanded;
                    expandArea.style.display = expanded ? "block" : "none";
                };

                // Input row
                const inputRow = expandArea.createDiv({ attr:{ style:"display:flex;gap:8px;align-items:center;"}});
                const keyInp = inputRow.createEl("input", { attr:{ type:"password", placeholder: hasKey ? "••••••••" : p.placeholder,
                    style:`flex:1;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);
                    border-radius:9px;padding:10px 12px;color:#fff;font-size:0.8em;outline:none;transition:border-color 0.2s;`}});
                keyInp.onfocus=()=>{ keyInp.style.borderColor="var(--zos-accent,#6366f1)"; };
                keyInp.onblur=()=>{ keyInp.style.borderColor="rgba(255,255,255,0.1)"; };

                const saveBtn = inputRow.createEl("button", { attr:{ style:`padding:9px 14px;border-radius:9px;font-size:0.72em;font-weight:700;
                    cursor:pointer;background:rgba(var(--zos-accent-rgb,99,102,241),0.12);
                    color:var(--zos-accent,#6366f1);border:1px solid rgba(var(--zos-accent-rgb,99,102,241),0.25);
                    transition:all 0.2s;white-space:nowrap;`}});
                saveBtn.innerText = "Verify & Save";

                const getKeyBtn = inputRow.createEl("button", { attr:{ style:`padding:9px 12px;border-radius:9px;font-size:0.7em;
                    background:transparent;border:1px solid rgba(255,255,255,0.08);color:rgba(255,255,255,0.3);
                    cursor:pointer;white-space:nowrap;transition:opacity 0.2s;`}});
                getKeyBtn.innerText = "Get key ↗";
                getKeyBtn.onclick = () => window.open(p.url, "_blank");

                const feedbackEl = expandArea.createDiv({ attr:{ style:"font-size:0.7em;margin-top:8px;min-height:16px;font-family:monospace;"}});

                saveBtn.onclick = async () => {
                    const val = keyInp.value.trim();
                    if(!val && !hasKey){ keyInp.style.borderColor="#ff5555"; return; }
                    if(!val) return;

                    saveBtn.innerText = "Verifying...";
                    saveBtn.style.pointerEvents = "none";
                    feedbackEl.style.color = "rgba(255,255,255,0.4)";
                    feedbackEl.innerText = `Testing connection to ${p.label}...`;

                    const result = await validateAIKey(p, val);

                    if(result.ok){
                        localStorage.setItem(p.id, val);
                        S.aiSaved = true;
                        statusDot.style.background = "#00ff88";
                        statusDot.style.boxShadow = "0 0 6px rgba(0,255,136,0.5)";
                        validationEl.innerText = "✓ verified";
                        validationEl.style.color = "#00ff88";
                        feedbackEl.style.color = "#00ff88";
                        feedbackEl.innerText = `✓ ${p.label} key is valid and working!`;
                        card.style.borderColor = "rgba(0,255,136,0.2)";
                        card.style.background = "rgba(0,255,136,0.04)";
                        keyInp.value = "";
                        keyInp.placeholder = "••••••••";
                        saveBtn.innerText = "✓ Saved";
                        saveBtn.style.color = "#00ff88";
                        saveBtn.style.background = "rgba(0,255,136,0.08)";
                        saveBtn.style.borderColor = "rgba(0,255,136,0.2)";
                    } else {
                        feedbackEl.style.color = "#ff5555";
                        feedbackEl.innerText = `✗ ${result.msg.slice(0,80)}`;
                        keyInp.style.borderColor = "#ff5555";
                        saveBtn.innerText = "Verify & Save";
                    }
                    saveBtn.style.pointerEvents = "";
                };
                keyInp.onkeydown = e => { if(e.key==="Enter") saveBtn.click(); };
            });

            body.createDiv({ attr:{ style:"font-size:0.7em;opacity:0.2;margin-top:10px;text-align:center;"}})
                .innerText = "You can skip this — AI features just won't work until a key is added.";
        },

        // -- REVIEW ----------------
        review(body){
            mkHeading(body, "Review & confirm", "Here's everything that will be saved when you launch.");

            const aiProvider = AI_PROVIDERS.find(p => (localStorage.getItem(p.id)||"").trim().length > 8);
            const gwPlugin   = getGoogleWorkspacePlugin();
            const gwEnabled  = isGoogleWorkspacePluginEnabled();
            const connected  = isGoogleWorkspaceConnected();
            const connectedEmail = getGoogleWorkspaceEmail();

            const items = [
                { icon:"✏️",  label:"Title",       value: S.title,                                  ok: !!S.title },
                { icon:"💬",  label:"Tagline",      value: S.subtitle || "(none)",                   ok: true },
                { icon:"🎨",  label:"Accent color", value: `${ACCENTS.find(a=>a.rgb===S.accentRgb)?.label||"Custom"} (${S.accentHex})`, ok: true },
                { icon:"🔌",  label:"Workspace plugin",  value: gwPlugin && gwEnabled ? "Installed & enabled ✓" : "Not detected/enabled — assignments won't sync", ok: !!(gwPlugin && gwEnabled) },
                { icon:"🔗",  label:"Google",       value: connected ? `Connected ${connectedEmail?"as "+connectedEmail:""}` : "Not connected — assignments won't load", ok: connected },
                { icon:"🤖",  label:"AI provider",  value: aiProvider ? `${aiProvider.label} ✓` : "None — AI features disabled", ok: !!aiProvider },
                { icon:"📂",  label:"Vault",        value: "CSS snippet + config note will be created", ok: true },
            ];

            items.forEach(item => {
                const row = body.createDiv({ attr:{ style:`
                    display:flex;align-items:center;gap:12px;padding:10px 14px;
                    background:rgba(255,255,255,0.03);border-radius:11px;
                    border:1px solid ${item.ok?"rgba(255,255,255,0.06)":"rgba(255,200,0,0.15)"};
                    margin-bottom:7px;
                `}});
                row.createDiv({ attr:{ style:"font-size:1em;flex-shrink:0;width:20px;text-align:center;"}}).innerText = item.icon;
                const info = row.createDiv({ attr:{ style:"flex:1;min-width:0;"}});
                info.createDiv({ attr:{ style:"font-size:0.68em;opacity:0.35;font-family:monospace;letter-spacing:1px;"}}).innerText = item.label.toUpperCase();
                info.createDiv({ attr:{ style:`font-size:0.82em;font-weight:600;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;
                    color:${item.ok?"rgba(255,255,255,0.85)":"#ffc800"};`}}).innerText = item.value;
                row.createDiv({ attr:{ style:`font-size:0.9em;flex-shrink:0;color:${item.ok?"#00ff88":"#ffc800"};`}}).innerText = item.ok ? "✓" : "⚠";
            });

            body.createDiv({ attr:{ style:"font-size:0.72em;opacity:0.25;margin-top:10px;text-align:center;"}})
                .innerText = "You can change any of this later from the dashboard settings.";
        },

        // -- DONE -----------------
        done(body){
            navFooter.style.display = "none";

            body.style.display = "flex";
            body.style.flexDirection = "column";
            body.style.alignItems = "center";
            body.style.justifyContent = "center";
            body.style.textAlign = "center";
            body.style.height = "100%";

            body.createDiv({ attr:{ style:`font-size:4em;margin-bottom:12px;
                filter:drop-shadow(0 0 30px rgba(0,255,136,0.6));
                animation:zos-pulse 2s ease-in-out infinite;`}}).innerText = "✦";

            body.createDiv({ attr:{ style:`font-size:2.2em;font-weight:900;letter-spacing:-1.5px;margin-bottom:10px;
                background:linear-gradient(135deg,#fff 0%,rgba(255,255,255,0.45) 100%);
                -webkit-background-clip:text;-webkit-text-fill-color:transparent;`}}).innerText = "You're all set!";

            body.createDiv({ attr:{ style:"opacity:0.4;font-size:0.85em;line-height:1.75;max-width:340px;margin-bottom:24px;"}})
                .innerText = `${S.title} is fully configured.\nLaunching your dashboard now...`;

            // Save everything
            (async () => {
                save("zos-banner-title",    S.title.trim().toUpperCase() || "DASHBOARD ZEN");
                save("zos-banner-subtitle", S.subtitle);
                save("zos-accent-rgb",      S.accentRgb);
                save("zos-accent-hex",      S.accentHex);
                save("zos-setup-complete",  "1");
                save("zos-wizard-complete", "1");
                save("zos-wizard-dismissed","1");

                // Apply accent
                document.documentElement.style.setProperty("--zos-accent",     S.accentHex);
                document.documentElement.style.setProperty("--zos-accent-rgb", S.accentRgb);

                // Save CSS snippet to vault
                await saveAccentSnippet(S.accentRgb, S.accentHex);
                // Save config note
                await saveConfigNote();
            })();

            // Countdown
            const countEl = body.createDiv({ attr:{ style:"font-size:0.82em;opacity:0.3;font-family:monospace;margin-bottom:20px;"}});
            let countdown = 3;
            countEl.innerText = `Launching in ${countdown}...`;
            const tick = setInterval(()=>{
                countdown--;
                if(countdown > 0){ countEl.innerText = `Launching in ${countdown}...`; }
                else {
                    clearInterval(tick);
                    countEl.innerText = "Launching!";
                }
            }, 1000);

            // Launch confetti
            launchConfetti(ov);

            // Fade out and launch dashboard
            setTimeout(()=>{
                ov.style.transition = "opacity 0.8s ease, transform 0.8s cubic-bezier(0.22,1,0.36,1)";
                ov.style.opacity = "0";
                ov.style.transform = "scale(1.04)";
                setTimeout(()=>{
                    ov.remove();
                    renderLeftCol();
                    renderRightCol();
                    fetchAndRender();
                    fetchAINews();
                }, 800);
            }, 3200);
        },
    };

    // -- RENDER STEP -----------------
    function renderStep(step, dir=1){
        slideArea.innerHTML = "";
        updateSidebar(step);

        // Back button
        backBtn.style.opacity   = step === 0 ? "0" : "1";
        backBtn.style.pointerEvents = step === 0 ? "none" : "auto";

        // Next button label
        const labels = {
            0:"Let's go →", 1:"Next →", 2:"Next →", 3:"Next →",
            4:"Next →", 5:"Next →", 6:"Next →", 7:"Finish & Launch 🚀"
        };
        nextBtn.innerText = labels[step] || "Continue →";

        // Skip button visibility
        const skippable = [3, 6]; // google, ai
        skipBtn.style.display = skippable.includes(step) ? "block" : "none";

        // Nav footer visibility
        navFooter.style.display = step === STEPS.length - 1 ? "none" : "flex";

        const body = slideArea.createDiv({ attr:{ style:"height:100%;display:flex;flex-direction:column;"}});
        slideIn(body, dir);

        const renderer = stepRenderers[STEPS[step].id];
        if(renderer) renderer(body);
    }

    // -- NAV -------------------------------
    nextBtn.onclick = () => {
        if(currentStep < STEPS.length - 1){
            currentStep++;
            renderStep(currentStep, 1);
        }
    };
    backBtn.onclick = () => {
        if(currentStep > 0){
            currentStep--;
            renderStep(currentStep, -1);
        }
    };
    skipBtn.onclick = () => {
        if(currentStep < STEPS.length - 1){
            currentStep++;
            renderStep(currentStep, 1);
        }
    };

    // Keyboard nav
    document.addEventListener("keydown", function wizardKeys(e){
        if(!document.body.contains(ov)){ document.removeEventListener("keydown", wizardKeys); return; }
        if(e.key === "ArrowRight" || (e.key === "Enter" && document.activeElement === document.body)) nextBtn.click();
        if(e.key === "ArrowLeft") backBtn.click();
    });

    renderStep(0, 1);
}

// -- CONFETTI ------------------------------
function launchConfetti(parent){
    const colors = ["#6366f1","#00ff88","#ffc800","#ff5578","#00e5ff","#b450ff","#ff8c00","#ffffff"];
    for(let i = 0; i < 100; i++){
        const size   = 5 + Math.random() * 8;
        const isRect = Math.random() > 0.4;
        const p = parent.createDiv({ attr:{ style:`
            position:fixed;pointer-events:none;z-index:999999;
            width:${size}px;height:${isRect ? size*0.4 : size}px;
            border-radius:${isRect ? "2px" : "50%"};
            background:${colors[Math.floor(Math.random()*colors.length)]};
            left:${Math.random()*100}vw;top:-20px;
        `}});
        const xDrift  = (Math.random() - 0.5) * 400;
        const duration= 1400 + Math.random() * 2000;
        const delay   = Math.random() * 900;
        p.animate([
            { transform:`translate(0,0) rotate(0deg)`,           opacity:1 },
            { transform:`translate(${xDrift}px,110vh) rotate(${360+Math.random()*720}deg)`, opacity:0 }
        ], { duration, delay, easing:"cubic-bezier(0.23,1,0.32,1)", fill:"forwards" });
        setTimeout(() => p.remove(), duration + delay + 200);
    }
}

// -- KICK OFF ----------------------------
window.addEventListener("resize",scheduleRightHeightSync);
boot();
```
