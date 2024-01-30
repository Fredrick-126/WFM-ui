import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { TranslateModule, MissingTranslationHandler } from '@ngx-translate/core';
import { MaterialModule } from '@wfm/material-module';
import { MissingTranslationHandlerService } from '@wfm/translate/missingtranslationhandler.service';
import { MissingTranslationSaverService } from '@wfm/translate/missingtranslationsaver.service';
import { FormlyModule } from '@ngx-formly/core';
import { IconModule } from '@wfm/shared/icon/icon.module';
import { DynamicRulesBuilderComponent } from './dynamic-rules-builder.component';

@NgModule({
  declarations: [DynamicRulesBuilderComponent],
  imports: [
    CommonModule,
    MaterialModule,
    ReactiveFormsModule,
    FormsModule,
    FormlyModule.forChild(),
    IconModule,

    TranslateModule.forChild({
      extend: true,
      missingTranslationHandler: {
        provide: MissingTranslationHandler,
        useExisting: MissingTranslationHandlerService,
        deps: [MissingTranslationSaverService]
      }
    })
  ],
  exports: [DynamicRulesBuilderComponent]
})
export class DynamicRulesBuilderModule {}
