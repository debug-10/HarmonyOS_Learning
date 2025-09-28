/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import TextInputComponent from '../view/TextInputComponent';
import TextCommonComponent from '../view/TextCommonComponent';

class HobbyItem {
  label?: string;
  isChecked?: boolean;
}

@Component
export struct PersonalInformation {
  @StorageLink('nikeName') nikeName: string = '';
  @StorageLink('signature') signature: string = '';
  @StorageLink('birthDate') birthDate: string = '';
  @StorageLink('sex') sex: ResourceStr = $r('app.string.male');
  @StorageLink('Hobbies') hobbies: string = '';
  @StorageLink('selectTime') selectTime: Date = new Date('2000-12-25T08:30:00');
  @State hobbyItems: HobbyItem[] = [];
  @StorageLink('select') select: number = 0;
  @State customPopup: boolean = false
  @State isSaved: boolean = false;
  @Consume('NavPathStack') pathStack: NavPathStack;

  // The popup constructor defines the contents of the pop-up
  @Builder
  PopupBuilder() {
    Row({ space: 2 }) {
      Text($r('app.string.save'))
        .fontSize(16)
        .opacity(0.9)
    }
    .width(200)
    .height(50)
    .padding(16)
  }

  @Builder
  NavDestinationTitle() {
    Column() {
      Row() {
        Image($r('app.media.dot_grid'))
          .width(24)
          .height(24)
      }
      .width(40)
      .height(40)
      .borderRadius(36)
      .backgroundColor('#E9E9E9')
      .justifyContent(FlexAlign.Center)
    }
    .alignItems(HorizontalAlign.End)
    .padding({ top: 8, right: 16 })
    .width('calc(100% - 56vp)')
  }

  build() {
    NavDestination() {
      Column() {
        Column({ space: 12 }) {
          Image($r('app.media.ic_avatar'))
            .width(56)
            .height(56)
            .alignSelf(ItemAlign.Center)
          Text($r('app.string.personalInformation'))
            .fontSize(17)
            .opacity(0.9)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        Column() {
          TextInputComponent({
            inputImage: $r('app.media.person'),
            text: this.nikeName,
            hintText: $r('app.string.nickname')
          })
        }

        Column() {
          TextCommonComponent({
            textImage: $r('app.media.calendar'),
            title: $r('app.string.date_of_birth'),
            content: this.birthDate,
          })
        }

        Column() {
          TextCommonComponent({
            textImage: $r('app.media.person_2'),
            title: $r('app.string.sex'),
            content: this.sex,
          })
        }

        Column() {
          TextInputComponent({
            inputImage: $r('app.media.doc_plaintext_and_pencil'),
            text: this.signature,
            hintText: $r('app.string.personal_signature')
          })
        }

        Column() {
          TextCommonComponent({
            textImage: $r('app.media.heart'),
            title: $r('app.string.Hobbies_multiple_choices'),
            content: this.hobbies,
          })
        }
      }
      .padding(16)
    }
    .title(this.NavDestinationTitle())
    .backgroundColor('#F1F3F5')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}