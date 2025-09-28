if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface PersonalInformation_Params {
    nikeName?: string;
    signature?: string;
    birthDate?: string;
    sex?: ResourceStr;
    hobbies?: string;
    selectTime?: Date;
    hobbyItems?: HobbyItem[];
    select?: number;
    customPopup?: boolean;
    isSaved?: boolean;
    pathStack?: NavPathStack;
}
import TextInputComponent from "@normalized:N&&&entry/src/main/ets/view/TextInputComponent&";
import TextCommonComponent from "@normalized:N&&&entry/src/main/ets/view/TextCommonComponent&";
class HobbyItem {
    label?: string;
    isChecked?: boolean;
}
export class PersonalInformation extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__nikeName = this.createStorageLink('nikeName', '', "nikeName");
        this.__signature = this.createStorageLink('signature', '', "signature");
        this.__birthDate = this.createStorageLink('birthDate', '', "birthDate");
        this.__sex = this.createStorageLink('sex', { "id": 16777222, "type": 10003, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" }, "sex");
        this.__hobbies = this.createStorageLink('Hobbies', '', "hobbies");
        this.__selectTime = this.createStorageLink('selectTime', new Date('2000-12-25T08:30:00'), "selectTime");
        this.__hobbyItems = new ObservedPropertyObjectPU([], this, "hobbyItems");
        this.__select = this.createStorageLink('select', 0, "select");
        this.__customPopup = new ObservedPropertySimplePU(false, this, "customPopup");
        this.__isSaved = new ObservedPropertySimplePU(false, this, "isSaved");
        this.__pathStack = this.initializeConsume('NavPathStack', "pathStack");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: PersonalInformation_Params) {
        if (params.hobbyItems !== undefined) {
            this.hobbyItems = params.hobbyItems;
        }
        if (params.customPopup !== undefined) {
            this.customPopup = params.customPopup;
        }
        if (params.isSaved !== undefined) {
            this.isSaved = params.isSaved;
        }
    }
    updateStateVars(params: PersonalInformation_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__nikeName.purgeDependencyOnElmtId(rmElmtId);
        this.__signature.purgeDependencyOnElmtId(rmElmtId);
        this.__birthDate.purgeDependencyOnElmtId(rmElmtId);
        this.__sex.purgeDependencyOnElmtId(rmElmtId);
        this.__hobbies.purgeDependencyOnElmtId(rmElmtId);
        this.__selectTime.purgeDependencyOnElmtId(rmElmtId);
        this.__hobbyItems.purgeDependencyOnElmtId(rmElmtId);
        this.__select.purgeDependencyOnElmtId(rmElmtId);
        this.__customPopup.purgeDependencyOnElmtId(rmElmtId);
        this.__isSaved.purgeDependencyOnElmtId(rmElmtId);
        this.__pathStack.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__nikeName.aboutToBeDeleted();
        this.__signature.aboutToBeDeleted();
        this.__birthDate.aboutToBeDeleted();
        this.__sex.aboutToBeDeleted();
        this.__hobbies.aboutToBeDeleted();
        this.__selectTime.aboutToBeDeleted();
        this.__hobbyItems.aboutToBeDeleted();
        this.__select.aboutToBeDeleted();
        this.__customPopup.aboutToBeDeleted();
        this.__isSaved.aboutToBeDeleted();
        this.__pathStack.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __nikeName: ObservedPropertyAbstractPU<string>;
    get nikeName() {
        return this.__nikeName.get();
    }
    set nikeName(newValue: string) {
        this.__nikeName.set(newValue);
    }
    private __signature: ObservedPropertyAbstractPU<string>;
    get signature() {
        return this.__signature.get();
    }
    set signature(newValue: string) {
        this.__signature.set(newValue);
    }
    private __birthDate: ObservedPropertyAbstractPU<string>;
    get birthDate() {
        return this.__birthDate.get();
    }
    set birthDate(newValue: string) {
        this.__birthDate.set(newValue);
    }
    private __sex: ObservedPropertyAbstractPU<ResourceStr>;
    get sex() {
        return this.__sex.get();
    }
    set sex(newValue: ResourceStr) {
        this.__sex.set(newValue);
    }
    private __hobbies: ObservedPropertyAbstractPU<string>;
    get hobbies() {
        return this.__hobbies.get();
    }
    set hobbies(newValue: string) {
        this.__hobbies.set(newValue);
    }
    private __selectTime: ObservedPropertyAbstractPU<Date>;
    get selectTime() {
        return this.__selectTime.get();
    }
    set selectTime(newValue: Date) {
        this.__selectTime.set(newValue);
    }
    private __hobbyItems: ObservedPropertyObjectPU<HobbyItem[]>;
    get hobbyItems() {
        return this.__hobbyItems.get();
    }
    set hobbyItems(newValue: HobbyItem[]) {
        this.__hobbyItems.set(newValue);
    }
    private __select: ObservedPropertyAbstractPU<number>;
    get select() {
        return this.__select.get();
    }
    set select(newValue: number) {
        this.__select.set(newValue);
    }
    private __customPopup: ObservedPropertySimplePU<boolean>;
    get customPopup() {
        return this.__customPopup.get();
    }
    set customPopup(newValue: boolean) {
        this.__customPopup.set(newValue);
    }
    private __isSaved: ObservedPropertySimplePU<boolean>;
    get isSaved() {
        return this.__isSaved.get();
    }
    set isSaved(newValue: boolean) {
        this.__isSaved.set(newValue);
    }
    private __pathStack: ObservedPropertyAbstractPU<NavPathStack>;
    get pathStack() {
        return this.__pathStack.get();
    }
    set pathStack(newValue: NavPathStack) {
        this.__pathStack.set(newValue);
    }
    // The popup constructor defines the contents of the pop-up
    PopupBuilder(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 2 });
            Row.width(200);
            Row.height(50);
            Row.padding(16);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777228, "type": 10003, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" });
            Text.fontSize(16);
            Text.opacity(0.9);
        }, Text);
        Text.pop();
        Row.pop();
    }
    NavDestinationTitle(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.alignItems(HorizontalAlign.End);
            Column.padding({ top: 8, right: 16 });
            Column.width('calc(100% - 56vp)');
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width(40);
            Row.height(40);
            Row.borderRadius(36);
            Row.backgroundColor('#E9E9E9');
            Row.justifyContent(FlexAlign.Center);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 16777235, "type": 20000, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" });
            Image.width(24);
            Image.height(24);
        }, Image);
        Row.pop();
        Column.pop();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            NavDestination.create(() => {
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                    Column.padding(16);
                }, Column);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create({ space: 12 });
                    Column.width('100%');
                    Column.alignItems(HorizontalAlign.Center);
                }, Column);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Image.create({ "id": 16777239, "type": 20000, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" });
                    Image.width(56);
                    Image.height(56);
                    Image.alignSelf(ItemAlign.Center);
                }, Image);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create({ "id": 16777226, "type": 10003, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" });
                    Text.fontSize(17);
                    Text.opacity(0.9);
                }, Text);
                Text.pop();
                Column.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                }, Column);
                {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        if (isInitialRender) {
                            let componentCall = new TextInputComponent(this, {
                                inputImage: { "id": 16777246, "type": 20000, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" },
                                text: this.__nikeName,
                                hintText: { "id": 16777225, "type": 10003, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" }
                            }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/PersonalInformation.ets", line: 86, col: 11 });
                            ViewPU.create(componentCall);
                            let paramsLambda = () => {
                                return {
                                    inputImage: { "id": 16777246, "type": 20000, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" },
                                    text: this.nikeName,
                                    hintText: { "id": 16777225, "type": 10003, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" }
                                };
                            };
                            componentCall.paramsGenerator_ = paramsLambda;
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                    }, { name: "TextInputComponent" });
                }
                Column.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                }, Column);
                {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        if (isInitialRender) {
                            let componentCall = new TextCommonComponent(this, {
                                textImage: { "id": 16777232, "type": 20000, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" },
                                title: { "id": 16777221, "type": 10003, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" },
                                content: this.__birthDate,
                            }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/PersonalInformation.ets", line: 94, col: 11 });
                            ViewPU.create(componentCall);
                            let paramsLambda = () => {
                                return {
                                    textImage: { "id": 16777232, "type": 20000, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" },
                                    title: { "id": 16777221, "type": 10003, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" },
                                    content: this.birthDate
                                };
                            };
                            componentCall.paramsGenerator_ = paramsLambda;
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                    }, { name: "TextCommonComponent" });
                }
                Column.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                }, Column);
                {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        if (isInitialRender) {
                            let componentCall = new TextCommonComponent(this, {
                                textImage: { "id": 16777247, "type": 20000, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" },
                                title: { "id": 16777229, "type": 10003, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" },
                                content: this.__sex,
                            }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/PersonalInformation.ets", line: 102, col: 11 });
                            ViewPU.create(componentCall);
                            let paramsLambda = () => {
                                return {
                                    textImage: { "id": 16777247, "type": 20000, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" },
                                    title: { "id": 16777229, "type": 10003, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" },
                                    content: this.sex
                                };
                            };
                            componentCall.paramsGenerator_ = paramsLambda;
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                    }, { name: "TextCommonComponent" });
                }
                Column.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                }, Column);
                {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        if (isInitialRender) {
                            let componentCall = new TextInputComponent(this, {
                                inputImage: { "id": 16777234, "type": 20000, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" },
                                text: this.__signature,
                                hintText: { "id": 16777227, "type": 10003, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" }
                            }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/PersonalInformation.ets", line: 110, col: 11 });
                            ViewPU.create(componentCall);
                            let paramsLambda = () => {
                                return {
                                    inputImage: { "id": 16777234, "type": 20000, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" },
                                    text: this.signature,
                                    hintText: { "id": 16777227, "type": 10003, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" }
                                };
                            };
                            componentCall.paramsGenerator_ = paramsLambda;
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                    }, { name: "TextInputComponent" });
                }
                Column.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                }, Column);
                {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        if (isInitialRender) {
                            let componentCall = new TextCommonComponent(this, {
                                textImage: { "id": 16777237, "type": 20000, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" },
                                title: { "id": 16777220, "type": 10003, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" },
                                content: this.__hobbies,
                            }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/pages/PersonalInformation.ets", line: 118, col: 11 });
                            ViewPU.create(componentCall);
                            let paramsLambda = () => {
                                return {
                                    textImage: { "id": 16777237, "type": 20000, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" },
                                    title: { "id": 16777220, "type": 10003, params: [], "bundleName": "com.example.codelab_v1", "moduleName": "entry" },
                                    content: this.hobbies
                                };
                            };
                            componentCall.paramsGenerator_ = paramsLambda;
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                    }, { name: "TextCommonComponent" });
                }
                Column.pop();
                Column.pop();
            }, { moduleName: "entry", pagePath: "entry/src/main/ets/pages/PersonalInformation" });
            NavDestination.title({ builder: () => {
                    this.NavDestinationTitle.call(this);
                } });
            NavDestination.backgroundColor('#F1F3F5');
            NavDestination.expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]);
        }, NavDestination);
        NavDestination.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
