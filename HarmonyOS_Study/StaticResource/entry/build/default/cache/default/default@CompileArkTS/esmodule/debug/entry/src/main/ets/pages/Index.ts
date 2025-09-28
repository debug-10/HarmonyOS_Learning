if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface Index_Params {
    pathStack?: NavPathStack;
}
import { PersonalInformation } from "@normalized:N&&&entry/src/main/ets/pages/PersonalInformation&";
class Index extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__pathStack = new ObservedPropertyObjectPU(new NavPathStack(), this, "pathStack");
        this.addProvidedVar("NavPathStack", this.__pathStack, false);
        this.addProvidedVar("pathStack", this.__pathStack, false);
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: Index_Params) {
        if (params.pathStack !== undefined) {
            this.pathStack = params.pathStack;
        }
    }
    updateStateVars(params: Index_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__pathStack.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__pathStack.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __pathStack: ObservedPropertyObjectPU<NavPathStack>;
    get pathStack() {
        return this.__pathStack.get();
    }
    set pathStack(newValue: NavPathStack) {
        this.__pathStack.set(newValue);
    }
    PagesMap(name: string, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (name === 'PersonalInformation') {
                this.ifElseBranchUpdateFunction(0, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new PersonalInformation(this, {}, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/Index.ets", line: 26, col: 7 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {};
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                            }
                        }, { name: "PersonalInformation" });
                    }
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Navigation.create(this.pathStack, { moduleName: "entry", pagePath: "entry/src/main/ets/pages/Index", isUserCreateStack: true });
            Navigation.backgroundColor('#F1F3F5');
            Navigation.navDestination({ builder: this.PagesMap.bind(this) });
            Navigation.mode(NavigationMode.Stack);
            Navigation.hideToolBar(true);
            Navigation.expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]);
        }, Navigation);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.height('100%');
            Column.justifyContent(FlexAlign.SpaceBetween);
            Column.padding({
                left: 16,
                right: 16,
                bottom: 16
            });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777224, "type": 10003, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" });
            Text.fontSize(30);
            Text.opacity(0.9);
            Text.fontWeight(FontWeight.Bold);
            Text.width('100%');
            Text.height(56);
            Text.margin({ top: 56 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 12 });
            Column.height(248);
            Column.width('100%');
            Column.justifyContent(FlexAlign.End);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel({ "id": 16777226, "type": 10003, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" });
            Button.onClick(() => {
                this.pathStack.pushPath({ name: 'PersonalInformation' });
            });
            Button.width('100%');
        }, Button);
        Button.pop();
        Column.pop();
        Column.pop();
        Navigation.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName(): string {
        return "Index";
    }
}
registerNamedRoute(() => new Index(undefined, {}), "", { bundleName: "com.example.codelab_v1", moduleName: "entry", pagePath: "pages/Index", pageFullPath: "entry/src/main/ets/pages/Index", integratedHsp: "false", moduleType: "followWithHap" });
