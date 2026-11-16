{{/*
Common Deployment template
*/}}
{{- define "common.deployment" -}}
apiVersion: apps/v1
kind: Deployment

metadata:
  name: {{ include "common.fullname" . }}
  labels:
    {{- include "common.labels" . | nindent 4 }}

spec:
  replicas: {{ .Values.replicaCount }}

  selector:
    matchLabels:
      {{- include "common.selectorLabels" . | nindent 6 }}

  template:
    metadata:
      labels:
        {{- include "common.selectorLabels" . | nindent 8 }}

    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}

          ports:
            - name: http
              containerPort: {{ .Values.containerPort }}
              protocol: TCP

          {{- with .Values.envFrom }}
          envFrom:
            {{- toYaml . | nindent 12 }}
          {{- end }}

          {{- with .Values.resources }}
          resources:
            {{- toYaml . | nindent 6 }}
          {{- end }}
{{- end }}