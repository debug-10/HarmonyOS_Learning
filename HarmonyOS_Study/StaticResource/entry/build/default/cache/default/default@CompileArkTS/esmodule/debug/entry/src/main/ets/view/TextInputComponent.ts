if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface TextInputComponent_Params {
    inputImage?: Resource;
    hintText?: ResourceStr;
    text?: string;
}
export default class TextInputComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.inputImage = undefined;
        this.hintText = undefined;
        this.__text = new SynchedPropertySimpleTwoWayPU(params.text, this, "text");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: TextInputComponent_Params) {
        if (params.inputImage !== undefined) {
            this.inputImage = params.inputImage;
        }
        if (params.hintText !== undefined) {
            this.hintText = params.hintText;
        }
    }
    updateStateVars(params: TextInputComponent_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__text.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__text.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private inputImage?: Resource;
    private hintText?: ResourceStr;
    private __text: SynchedPropertySimpleTwoWayPU<string>;
    get text() {
        return this.__text.get();
    }
    set text(newValue: string) {
        this.__text.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.margin({ top: 24 });
            Row.borderRadius(24);
            Row.backgroundColor(Color.White);
            Row.width('100%');
            Row.height(64);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(this.inputImage !== undefined ? this.inputImage : '');
            Image.width(26);
            Image.height(26);
            Image.margin({ left: 12 });
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TextInput.create({ placeholder: this.hintText, text: this.text });
            TextInput.fontSize(17);
            TextInput.padding({ left: 12 });
            TextInput.backgroundColor(Color.White);
            TextInput.fontWeight(FontWeight.Normal);
            TextInput.fontStyle(FontStyle.Normal);
            TextInput.fontColor(Color.Black);
            TextInput.opacity(0.9);
            TextInput.margin({ right: 32 });
            TextInput.layoutWeight(1);
            TextInput.height(48);
            TextInput.enableKeyboardOnFocus(false);
            TextInput.onChange((value: string) => {
                this.text = value;
            });
        }, TextInput);
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
