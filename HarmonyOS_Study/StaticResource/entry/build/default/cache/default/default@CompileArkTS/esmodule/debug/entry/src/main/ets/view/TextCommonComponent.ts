if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface TextCommonComponent_Params {
    content?: ResourceStr;
    textImage?: Resource;
    title?: ResourceStr;
    onItemClick?;
}
export default class TextCommonComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__content = new SynchedPropertyObjectTwoWayPU(params.content, this, "content");
        this.textImage = undefined;
        this.title = undefined;
        this.onItemClick = (): void => {
        };
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: TextCommonComponent_Params) {
        if (params.textImage !== undefined) {
            this.textImage = params.textImage;
        }
        if (params.title !== undefined) {
            this.title = params.title;
        }
        if (params.onItemClick !== undefined) {
            this.onItemClick = params.onItemClick;
        }
    }
    updateStateVars(params: TextCommonComponent_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__content.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__content.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __content: SynchedPropertySimpleOneWayPU<ResourceStr>;
    get content() {
        return this.__content.get();
    }
    set content(newValue: ResourceStr) {
        this.__content.set(newValue);
    }
    private textImage?: Resource;
    private title?: ResourceStr;
    private onItemClick;
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.margin({ top: 24 });
            Row.borderRadius(24);
            Row.backgroundColor(Color.White);
            Row.width('100%');
            Row.height(64);
            Row.onClick(this.onItemClick);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(this.textImage !== undefined ? this.textImage : '');
            Image.width(26);
            Image.height(26);
            Image.margin({ left: 12 });
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.title);
            Text.fontSize(17);
            Text.margin({ left: 16 });
            Text.height('100%');
            Text.opacity(0.9);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.content);
            Text.fontSize(17);
            Text.opacity(0.9);
            Text.textAlign(TextAlign.End);
            Text.textOverflow({ overflow: TextOverflow.Ellipsis });
            Text.maxLines(1);
            Text.margin({
                left: 16,
                right: 7
            });
            Text.height('100%');
            Text.layoutWeight(1);
            Text.width('100%');
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 16777233, "type": 20000, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" });
            Image.width(13);
            Image.height(13);
            Image.margin({ right: 14 });
        }, Image);
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
