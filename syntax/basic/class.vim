"Class
syntax keyword typescriptAbstract              abstract
  \ nextgroup=typescriptClassKeyword,typescriptMethodSignature,typescriptPropertySignature
  \ skipwhite skipnl
syntax keyword typescriptClassKeyword          class
  \ nextgroup=typescriptClassName,typescriptClassExtends,typescriptClassBlock
  \ skipwhite

syntax match   typescriptClassName             contained /\v[A-Za-z_$]\k*/
  \ nextgroup=typescriptClassBlock,typescriptClassExtends,typescriptClassTypeParameter
  \ skipwhite skipnl

syntax region typescriptClassTypeParameter
  \ start=/</ end=/>/
  \ contains=typescriptTypeParameter
  \ nextgroup=typescriptClassBlock,typescriptClassExtends
  \ contained skipwhite skipnl

syntax keyword typescriptClassExtends          contained extends implements nextgroup=typescriptClassHeritage skipwhite skipnl

syntax match   typescriptClassHeritage         contained /\v(\k|\.|\(|\))+/
  \ nextgroup=typescriptClassBlock,typescriptClassExtends,typescriptMixinComma,typescriptClassTypeArguments
  \ contains=typescriptExpression
  \ skipwhite skipnl
  \ contained

syntax region typescriptClassTypeArguments matchgroup=typescriptTypeBrackets
  \ start=/</ end=/>/ skip=/\s*,\s*/
  \ contains=@typescriptType
  \ nextgroup=typescriptClassBlock,typescriptClassExtends,typescriptMixinComma
  \ contained skipwhite skipnl

syntax match typescriptMixinComma /,/ contained nextgroup=typescriptClassHeritage skipwhite skipnl

syntax region  typescriptClassBlock matchgroup=typescriptBraces start=/{/ end=/}/
  \ contains=@typescriptPropertyMemberDeclaration,typescriptMethodDef,typescriptDecorator,typescriptAbstract,typescriptAsyncFuncKeyword,@typescriptComments,typescriptMethodSignature
  \ contained fold

syntax keyword typescriptClassStatic static
  \ nextgroup=typescriptMethodDef,@typescriptMemberDeclaration
  \ skipwhite contained

syntax cluster typescriptPropertyMemberDeclaration contains=
  \ typescriptClassStatic,
  \ typescriptAccessibilityModifier,
  \ typescriptMemberVariableDeclaration

syntax match typescriptMemberVariableDeclaration /\v[A-Za-z_$]\k*(\?|\!)?\s*\ze:/
  \ nextgroup=typescriptTypeAnnotation
  \ contained skipwhite

syntax match typescriptMemberVariableDeclaration /[A-Za-z_$]\k*\s*=/
  \ nextgroup=@typescriptExpression
  \ contained skipwhite skipnl

syntax match typescriptMemberVariableDeclaration /[A-Za-z_$]\k*:.\+=>\@!/
  \ contains=typescriptTypeAnnotation
  \ nextgroup=@typescriptExpression
  \ contained skipwhite skipnl

syntax keyword typescriptInterfaceKeyword          interface nextgroup=typescriptInterfaceName skipwhite
syntax match   typescriptInterfaceName             contained /\k\+/ nextgroup=typescriptObjectType,typescriptInterfaceExtends skipwhite
syntax match   typescriptInterfaceName             contained /\k\+\ze\s*</
  \ nextgroup=typescriptInterfaceTypeParameter
  \ contained
  \ skipwhite
syntax region typescriptInterfaceTypeParameter
  \ start=/</ end=/>/
  \ contains=typescriptTypeParameter
  \ nextgroup=typescriptObjectType,typescriptInterfaceExtends
  \ contained
  \ skipwhite

syntax keyword typescriptInterfaceExtends          contained extends nextgroup=typescriptInterfaceHeritage skipwhite skipnl

syntax match typescriptInterfaceHeritage contained /\v(\k|\.)+/
  \ nextgroup=typescriptObjectType,typescriptInterfaceComma
  \ skipwhite
syntax match typescriptInterfaceHeritage contained /\v(\k|\.)+\ze\s*\</
  \ nextgroup=typescriptInterfaceTypeArguments
  \ skipwhite

syntax region typescriptInterfaceTypeArguments matchgroup=typescriptTypeBrackets
  \ start=/</ end=/>/ skip=/\s*,\s*/
  \ contains=@typescriptType
  \ nextgroup=typescriptObjectType,typescriptInterfaceComma
  \ contained skipwhite

syntax match typescriptInterfaceComma /,/ contained nextgroup=typescriptInterfaceHeritage skipwhite skipnl
