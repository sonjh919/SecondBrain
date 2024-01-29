<%_*
const run_type = 2;

/*
run_type = 0; // callout 형식만 대화상자에서 고른 다음 바로 노트에서 글 작성 
run_type = 1; // 폴딩과 제목, 내용을 따로따로 입력 (키보드만으로 내용을 입력할 수 있음.)
run_type = 2; // 폴딩과 제목, 내용을 하나의 대화 상자에서 입력 (callout 모양 그대로 보며 내용을 입력할 수 있음)

* 되도록 obsidian 자체의 스타일로 callout을 보여주도록 함.
* callout 안의 callout을 사용할 수 있음 (callout 중첩)


다음 링크들에서 영감을 받음.
이 소스 코드를 되도록 바꾸지 않으려고 함.

Callout 쉽게 넣기 템플릿 : 네이버 카페  
https://cafe.naver.com/obsidianary/3804  

Insert Callout Template · SilentVoid13/Templater · Discussion #922  
https://github.com/SilentVoid13/Templater/discussions/922  


eoureo
@2023-04-13 20:00:00
*/

// import { App, Notice, SuggestModal } from "obsidian";
const { App, Notice, Modal, SuggestModal, ButtonComponent, TextComponent } = tp.obsidian;

const editorPosition = app.workspace.activeLeaf.view.editor.getCursor();
const line_string = app.workspace.activeLeaf.view.editor.getLine(editorPosition.line);
const line_prefix = line_string.substring(0, editorPosition.ch);
// console.log(editorPosition);
// console.log(line_string);
// console.log(line_prefix);

// callout은 줄 맨 앞이나 "> " 뒤에 넣을 수 있습니다.
if(!/^[> ]*$/.test(line_prefix)) {
  let message = `callout을 삽입할 수 없는 위치에 커서(캐럿)가 있습니다.`;
  new Notice(message);
  console.log(message);
  return;
}

// obsidian에서 callout 정보를 얻는 방법을 찾지 못해 Hard coding 함.
const CalloutTypes = [
  ["note", 'Note', 'lucide-pencil'],
  ["info", 'Info', 'lucide-info'],
  ["todo", 'Todo', 'lucide-check-circle-2'],
  ["abstract", 'Abstract', 'lucide-clipboard-list'],
  ["summary", 'Summary', 'lucide-clipboard-list'],
  ["tldr", 'TLDR', 'lucide-clipboard-list'],
  ["tip", 'Tip', 'lucide-flame'],
  ["hint", 'Hint', 'lucide-flame'],
  ["important", 'Important', 'lucide-flame'],
  ["success", 'Success', 'lucide-check'],
  ["check", 'Check', 'lucide-check'],
  ["done", 'Done', 'lucide-check'],
  ["question", 'Question', 'help-circle'],
  ["help", 'Help', 'help-circle'],
  ["faq", 'FAQ', 'help-circle'],
  ["warning", 'Warning', 'lucide-alert-triangle'],
  ["caution", 'Caution', 'lucide-alert-triangle'],
  ["attention", 'Attention', 'lucide-alert-triangle'],
  ["failure", 'Failure', 'lucide-x'],
  ["fail", 'Fail', 'lucide-x'],
  ["missing", 'Missing', 'lucide-x'],
  ["danger", 'Danger', 'lucide-zap'],
  ["error", 'Error', 'lucide-zap'],
  ["bug", 'Bug', 'lucide-bug'],
  ["example", 'Example', 'lucide-list'],
  ["quote", 'Quote', 'quote-glyph'],
  ["cite", 'Cite', 'quote-glyph'],
  ["glyph", 'Glyph', 'quote-glyph']
];

// // list all callouts
// for(var type of CalloutTypes) {
//   tR += `> [!${type[0]}]- \n`;
//   tR += `> ${type[1]}\n`;
//   tR += `> ${type[2]}\n`;
//   tR += `\n`;
// }
// return tR;

// callout list 클래스
// obsidian 자체의 스타일로 callout을 보여줌.
class ListModal extends SuggestModal {
  
  constructor(app, onSubmit) {
    super(app);
    this.onSubmit = onSubmit;
  }

  // Returns all available suggestions.
  getSuggestions(query) {
    return CalloutTypes.filter((type) => 
      type[0].toLowerCase().includes(query.toLowerCase())
    );
  }
  
  // Renders each suggestion item.
  renderSuggestion(type, el) {
    let callout_block = el.createDiv({cls:"cm-embed-block markdown-rendered cm-callout", attr: {"data-callout": type[0], "data-callout-fold": "-"}});
    
    let callout_div = callout_block.createDiv({cls:"callout is-collapsed", attr: {"data-callout": type[0], "data-callout-fold": "-"}});

    let callout_title = callout_div.createDiv({cls:"callout-title"});

    let callout_icon = callout_title.createDiv({cls:"callout-icon"});
    tp.obsidian.setIcon(callout_icon, type[2]);
    
    callout_title.createDiv({cls:"callout-title-inner", text: type[1]});
    
    let callout_fold = callout_title.createDiv({cls:"callout-fold"});
    tp.obsidian.setIcon(callout_fold, "lucide-chevron-down");
  }

  // Perform action on the selected suggestion.
  onChooseSuggestion(type, evt) {
    // new Notice(`Selected ${type[0]}`);
    // console.log(`Selected ${type[0]}`);
    this.onSubmit(type);
  }
}

async function get_callout_type() {
  return new Promise((resolve, reject) => {
    let listModal = new ListModal(app, function(callout) {
      if(callout) {
        resolve(callout);
      }
      else {
        reject("");
      }
    });

    listModal.containerEl.classList.add("myListModal");

    listModal.containerEl.createEl("style", { text: `
    .myListModal .prompt-results { z-index: 9999; }
    .myListModal .callout { margin: 0; } 
    .myListModal .callout-content { display: none; } 
    `});

    listModal.open();
  });
}

// calloutType - 이전 코드들에서는 String. 이 소스에서는 Array.
let calloutType = await get_callout_type();

console.log("calloutType:", calloutType);

app.workspace.activeLeaf.view.editor.focus(); // 다시 노트가 활성화 되어 바로 글을 입력할 수 있게 함.

let foldState;
let title;
let calloutContent;
// Run Type: 0 ##################################################
if(run_type === 0) {
  // tR += `> [!${calloutType[0]}]+ `;
  tR = `> [!${calloutType[0]}]+ ${tp.file.cursor()}`;
  return tR;
}
// Run Type: 1 ##################################################
else if(run_type === 1) {
  foldState = await tp.system.suggester(["접기 사용 안함", "접기 사용(펼침 상태)", "접기 사용(접은 상태)"], ["", "+", "-"], false, "콜아웃 접기 기능을 사용할까요?")
  if(foldState == null) {
    foldState = "";
  }

  title = await tp.system.prompt("콜아웃 제목은?(선택사항)", "")
  if(title == null) {
    title = "";
  }

  calloutContent = await tp.system.prompt("콜아웃 내용은?(선택사항, 줄바꿈은 Shift + 엔터)", "", false, true)
  if (calloutContent != null) {
    calloutContent = calloutContent.replaceAll("\n", "\n> ");
  }
  else {
    return; // submit 버튼을 안누르고 닫히면 에러 없이 템플레이터 마치기
  }
}
// Run Type: 2 ##################################################
else {

  // callout 내용 입력 대화 상자 - 클래스
  class CalloutModal extends Modal {

    constructor(app, callout_type, onSubmit) {
      super(app);
      this.callout_type = callout_type;
      this.onSubmit = onSubmit;
      this._fold_state = 1;
    }

    onOpen() {
      let { contentEl } = this;

      // contentEl.classList.add("myCalloutModal");
      contentEl.parentElement.classList.add("myCalloutModal");

      contentEl.createEl("style", {
        text: `
        .myCalloutModal { max-height: 80vh; width: 800px; } 
        .myCalloutModal .cm-embed-block .callout-title-inner { min-width: 8em; } 
        .myCalloutModal .callout-content > p { min-height: 6em; max-height: calc(80vh - 200px); } 
        .myCalloutModal .callout { margin: 4px; } 
        .myCalloutModal .header { text-align: right; display: flex; align-itmes: stretch; margin-top: 10px; padding: 0 4px; } 
        .myCalloutModal .header * { text-align: right; flex-grow: 0; align-self: baseline; } 
        .myCalloutModal .header input { margin-left: 1em; } 
        .myCalloutModal .header span.sizer { text-align: right; flex-grow: 10; } 
        .myCalloutModal .footer { text-align: right; padding: 0 4px; } 
        .myCalloutModal .footer * { margin-left: 4px; }
        .myCalloutModal .hide { display: none; } 
        .myCalloutModal .callout_type { display: inline-block;
          height: var(--input-height);
          color: rgb(var(--callout-color));
          align-self: auto;
          margin: 0;
          padding: 0 0.5em;
          line-height: var(--input-height);} 
        .myCalloutModal [contenteditable]:empty:before {
          content: attr(placeholder);
        }
        `});

      let div_head = contentEl.createDiv({ cls: "header" });

      new ButtonComponent(div_head).setButtonText("Callout Type")
        .setIcon("lucide-refresh-cw")
        .onClick(async () => {
          console.log("Callout Type!!!!");
          let calloutType_new = await get_callout_type();
          console.log("calloutType_new:", calloutType_new);

          this.callout_div.setAttribute("data-callout", calloutType_new[0]);
          tp.obsidian.setIcon(this.callout_icon, calloutType_new[2]);
          this.text_callout_type.innerText = calloutType_new[1];
          this.text_callout_type.setAttribute("data-callout", calloutType_new[0]);
        });

      this.text_callout_type = div_head.createEl("div", { text: this.callout_type[1], cls: "callout_type callout callout-title callout-title-inner", attr: { "data-callout": calloutType[0] } });

      div_head.createEl("span", { text: "Fold:", cls: "sizer" });

      this.fold_radios = [];
      this.fold_radios.push(div_head.createEl("input", { attr: { type: "radio", id: "NoFold", name: "foldState", value: "0" } }));
      div_head.createEl("label", { text: "No", attr: { for: "NoFold" } });
      this.fold_radios.push(div_head.createEl("input", { attr: { type: "radio", id: "Expanded", name: "foldState", value: "1" } }));
      div_head.createEl("label", { text: "➕", attr: { for: "Expanded" } });
      this.fold_radios.push(div_head.createEl("input", { attr: { type: "radio", id: "Collapsed", name: "foldState", value: "2" } }));
      div_head.createEl("label", { text: "➖", attr: { for: "Collapsed" } });
      let this_modal = this;
      this.fold_radios.forEach(radio => {
        radio.addEventListener("change", function (e) {
          this_modal.fold_state = parseInt(e.target.value);
        });
      });

      let callout_block = contentEl.createDiv({ cls: "cm-embed-block markdown-rendered cm-callout", attr: { "data-callout": calloutType[0], "data-callout-fold": "-" } });

      this.callout_div = callout_block.createDiv({ cls: "callout", attr: { "data-callout": calloutType[0], "data-callout-fold": "-" } });

      let callout_title = this.callout_div.createDiv({ cls: "callout-title" });

      this.callout_icon = callout_title.createDiv({ cls: "callout-icon" });
      tp.obsidian.setIcon(this.callout_icon, calloutType[2]);

      this.title = callout_title.createDiv({ cls: "callout-title-inner", attr: { contenteditable: "plaintext-only", placeholder: "제목 입럭" } });

      this.callout_fold = callout_title.createDiv({ cls: "callout-fold" });
      tp.obsidian.setIcon(this.callout_fold, "lucide-chevron-down");

      let callout_content = this.callout_div.createDiv({ cls: "callout-content" });

      this.callout_editor = callout_content.createEl("p", { attr: { contenteditable: "plaintext-only", placeholder: "내용 입럭" } });

      let div_foot = contentEl.createDiv({ cls: "footer" });

      new ButtonComponent(div_foot).setButtonText("Cancel").onClick(() => {
        this.close();
      });

      new ButtonComponent(div_foot).setButtonText("OK").onClick(() => {
        this.close();
        let result = {
          foldState: ["", "+", "-"][this.fold_state],
          title: this.title.innerText,
          calloutContent: this.callout_editor.innerText.replaceAll("\n", "\n> ")
        }
        this.onSubmit(result);
      });

      this.fold_radios[1].checked = true;
      this.fold_state = 1;

      this.title.focus();
    }

    get fold_state() {
      return this._fold_state;
    }

    set fold_state(index) {
      switch (index) {
        case 0:
          this.callout_fold.classList.add("hide");
          break;
        case 1:
          this.callout_div.classList.remove("is-collapsed");
          this.callout_fold.classList.remove("hide");
          break;
        case 2:
          this.callout_div.classList.add("is-collapsed");
          this.callout_fold.classList.remove("hide");
          break;
      }
      this._fold_state = index;
    }

    onClose() {
      let { contentEl } = this;
      contentEl.empty();
    }
  }

  // callout 내용 입력 대화 상자 실행
  ({ foldState, title, calloutContent } = await new Promise((resolve, reject) => {
    let calloutModal = new CalloutModal(app, calloutType, function (result) {
      if (result) {
        resolve(result);
      }
      else {
        reject("");
      }
    });

    calloutModal.open();
    calloutModal.title.focus();
  }));
}
// Run Type: 2 - End #############################################

// Array에서 String으로 바꿔줌.
if(calloutType instanceof Array) {
  calloutType = calloutType[0];
}

if (calloutType != null) {
  let content = '> [!' + calloutType + ']' + foldState + ' ' + title + '\n> ' + calloutContent.split("\n").map(line => line_prefix + line).join("\n") + tp.file.cursor();
  return content;
}

return;
_%>