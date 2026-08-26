{{/*
Expand the name of the chart.
*/}}
{{- define "graphwise-workflows.name" -}}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | replace "_" "-" | trimSuffix "-" }}
{{- end }}

{{- define "graphwise-workflows.runners.name" -}}
  {{- printf "%s-%s" (include "graphwise-workflows.name" .) "task-runners" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "graphwise-workflows.bootstrap.job.name" -}}
  {{- printf "%s-%s" (include "graphwise-workflows.name" .) "bootstrap" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "graphwise-workflows.fullname" -}}
  {{- if .Values.fullnameOverride }}
    {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
  {{- else }}
    {{- $name := default .Chart.Name .Values.nameOverride }}
    {{- if contains $name .Release.Name }}
      {{- .Release.Name | trunc 63 | trimSuffix "-" }}
    {{- else }}
      {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
    {{- end }}
  {{- end }}
{{- end }}

{{- define "graphwise-workflows.runners.fullname" -}}
  {{- printf "%s-%s" (include "graphwise-workflows.fullname" .) "task-runners" | trunc 63 | replace "_" "-" | trimSuffix "-" }}
{{- end }}

{{- define "graphwise-workflows.secrets.encryption.fullname" -}}
  {{- printf "%s-%s" (include "graphwise-workflows.fullname" .) "encryption" | trunc 63 | replace "_" "-" | trimSuffix "-" }}
{{- end }}

{{- define "graphwise-workflows.runners.secrets.token.fullname" -}}
  {{- printf "%s-%s" (include "graphwise-workflows.fullname" .) "task-runners-token" | trunc 63 | replace "_" "-" | trimSuffix "-" }}
{{- end }}

{{- define "graphwise-workflows.bootstrap.job.fullname" -}}
  {{- printf "%s-%s" (include "graphwise-workflows.fullname" .) "bootstrap" | trunc 63 | replace "_" "-" | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "graphwise-workflows.chart" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "graphwise-workflows.labels" -}}
helm.sh/chart: {{ include "graphwise-workflows.chart" . }}
{{ include "graphwise-workflows.selectorLabels" . }}
app.kubernetes.io/version: {{ coalesce .Values.image.tag .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: graphwise-workflows
{{- if .Values.labels -}}
  {{- tpl (toYaml .Values.labels) . | nindent 0 -}}
{{- end -}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "graphwise-workflows.selectorLabels" -}}
app.kubernetes.io/name: {{ include "graphwise-workflows.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "graphwise-workflows.bootstrap.job.selectorLabels" -}}
app.kubernetes.io/name: {{ include "graphwise-workflows.bootstrap.job.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "graphwise-workflows.serviceAccountName" -}}
  {{- if .Values.serviceAccount.create }}
    {{- default (include "graphwise-workflows.fullname" .) .Values.serviceAccount.name }}
  {{- else }}
    {{- default "default" .Values.serviceAccount.name }}
  {{- end }}
{{- end }}

{{/*
Returns the namespace of the release.
*/}}
{{- define "graphwise-workflows.namespace" -}}
  {{- .Values.namespaceOverride | default .Release.Namespace | trunc 63 | trimSuffix "-" -}}
{{- end -}}
