{{/*
Expand the name of the chart.
*/}}
{{- define "cruise-control.name" -}}
{{- default .Chart.Name .Values.cruiseControl.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cruise-control.fullname" -}}
{{- if .Values.cruiseControl.fullnameOverride }}
{{- .Values.cruiseControl.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.cruiseControl.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cruise-control.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cruise-control.labels" -}}
helm.sh/chart: {{ include "cruise-control.chart" . }}
{{ include "cruise-control.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cruise-control.selectorLabels" -}}
app: {{ include "cruise-control.name" . }}
app.kubernetes.io/app: {{ include "cruise-control.name" . }}
app.kubernetes.io/name: {{ include "cruise-control.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "cruise-control.serviceAccountName" -}}
{{- if (default false .Values.cruiseControl.serviceAccount.create) }}
{{- default (include "cruise-control.fullname" .) .Values.cruiseControl.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.cruiseControl.serviceAccount.name }}
{{- end }}
{{- end }}
