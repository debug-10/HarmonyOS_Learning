if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface ModalTransition_Params {
}
import { getResourceString } from "@bundle:com.huawei.transitionanimation/entry/ets/utils/commonUtil";
export class ModalTransition extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: ModalTransition_Params) {
    }
    updateStateVars(params: ModalTransition_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    previewArea(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.borderRadius(12);
            Column.backgroundColor(Color.White);
            Column.width('100%');
            Column.padding(12);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 16777239, "type": 20000, params: [], "bundleName": "com.huawei.transitionanimation", "moduleName": "entry" });
            Image.width('100%');
            Image.height(147);
            Image.borderRadius(8);
            Image.margin({ bottom: 12 });
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777226, "type": 10003, params: [], "bundleName": "com.huawei.transitionanimation", "moduleName": "entry" });
            Text.width('100%');
            Text.textAlign(TextAlign.Start);
            Text.fontSize(16);
            Text.fontWeight(FontWeight.Medium);
            Text.fontColor({ "id": 125830982, "type": 10001, params: [], "bundleName": "com.huawei.transitionanimation", "moduleName": "entry" });
        }, Text);
        Text.pop();
        Column.pop();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            NavDestination.create(() => {
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                    Column.width('100%');
                    Column.height('100%');
                    Column.padding(16);
                }, Column);
                this.previewArea.bind(this)();
                Column.pop();
            }, { moduleName: "entry", pagePath: "entry/src/main/ets/pages/ModalTransition" });
            NavDestination.backgroundColor('#F1F3F5');
            NavDestination.title(getResourceString({ "id": 16777232, "type": 10003, params: [], "bundleName": "com.huawei.transitionanimation", "moduleName": "entry" }, this.getUIContext().getHostContext()!));
        }, NavDestination);
        NavDestination.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
