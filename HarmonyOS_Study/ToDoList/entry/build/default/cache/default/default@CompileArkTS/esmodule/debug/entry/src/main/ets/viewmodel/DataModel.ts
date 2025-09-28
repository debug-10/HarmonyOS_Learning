import CommonConstants from "@bundle:com.huawei.todolist/entry/ets/common/constant/CommonConstant";
/**
 * Saving and manipulating data displayed on the page.
 */
export class DataModel {
    /**
     * Saved Data.
     */
    public tasks: Array<Resource> = CommonConstants.TODO_DATA;
    /**
     * Get the data.
     */
    getData(): Array<Resource> {
        return this.tasks;
    }
}
export default new DataModel();
