{{/*
Combined image pull secrets
*/}}
{{- define "graphwise-workflows.combinedImagePullSecrets" -}}
  {{- $secrets := concat .Values.global.imagePullSecrets .Values.image.pullSecrets }}
  {{- tpl (toYaml $secrets) . -}}
{{- end -}}

{{/*
Renders the container image
*/}}
{{- define "graphwise-workflows.image" -}}
  {{- $repository := .Values.image.repository -}}
  {{- $tag := .Values.image.tag | default .Chart.AppVersion | toString -}}
  {{- $image := printf "%s:%s" $repository $tag -}}
  {{/* Add registry if present */}}
  {{- $registry := .Values.global.imageRegistry | default .Values.image.registry -}}
  {{- if $registry -}}
    {{- $image = printf "%s/%s" $registry $image -}}
  {{- end -}}
  {{/* Add SHA digest if provided */}}
  {{- if .Values.image.digest -}}
    {{- $image = printf "%s@%s" $image .Values.image.digest -}}
  {{- end -}}
  {{- $image -}}
{{- end -}}

{{/*
Renders the container image for the task runners
*/}}
{{- define "graphwise-workflows.runners.image" -}}
  {{- $repository := .Values.runners.image.repository -}}
  {{- $tag := .Values.runners.image.tag | toString -}}
  {{- $image := printf "%s:%s" $repository $tag -}}
  {{/* Add registry if present */}}
  {{- $registry := .Values.global.imageRegistry | default .Values.runners.image.registry -}}
  {{- if $registry -}}
    {{- $image = printf "%s/%s" $registry $image -}}
  {{- end -}}
  {{/* Add SHA digest if provided */}}
  {{- if .Values.runners.image.digest -}}
    {{- $image = printf "%s@%s" $image .Values.runners.image.digest -}}
  {{- end -}}
  {{- $image -}}
{{- end -}}

{{/*
Renders the external URL for the Graphwise Workflows engine.
*/}}

{{- define "graphwise-workflows.external-url" -}}
  {{- tpl .Values.configuration.externalUrl . -}}
{{- end -}}

{{- define "graphwise-workflows.external-url.host" -}}
  {{- $external_url := urlParse (include "graphwise-workflows.external-url" .) -}}
  {{- coalesce .Values.ingress.host $external_url.host -}}
{{- end -}}

{{/*
Ensures a trailing slash for proper static resource loading.
*/}}
{{- define "graphwise-workflows.external-url.path" -}}
  {{- $external_url := urlParse (include "graphwise-workflows.external-url" .) -}}
  {{- printf "%s/" ($external_url.path | trimSuffix "/") -}}
{{- end -}}

{{- define "graphwise-workflows.external-url.ingress-path" -}}
  {{- $external_url := urlParse (include "graphwise-workflows.external-url" .) -}}
  {{- coalesce .Values.ingress.path (include "graphwise-workflows.external-url.path" .) -}}
{{- end -}}

{{- define "graphwise-workflows.runners.mode" -}}
{{- ternary "external" "internal" .Values.runners.external -}}
{{- end -}}
