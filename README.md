# Cruise Control Helm Chart for MSK (Amazon Managed Streaming for Apache Kafka)

This Helm chart deploys [Cruise Control](https://github.com/linkedin/cruise-control) — a robust workload balancing and optimization tool — into a Kubernetes environment. It is tailored for use with **Amazon MSK (Managed Streaming for Apache Kafka)** but can be extended to support other Kafka clusters.

## Features

* Deploys Cruise Control on Kubernetes with a customizable container image.
* Supports Cruise Control UI via an optional Ingress.
* Integrates with Amazon MSK Kafka clusters using configurable bootstrap and ZooKeeper hosts.
* Allows configuration of broker capacities to support resource-aware optimization.
* Supports metrics ingestion via VictoriaMetrics or Prometheus.

## Components Deployed

* **Cruise Control backend**: The optimization engine responsible for workload balancing.
* **Cruise Control UI**: A frontend UI to monitor and manually trigger optimization proposals.

## Prerequisites

* Kubernetes cluster (e.g., EKS)
* Access to an MSK cluster with public/private brokers
* [VictoriaMetrics](https://victoriametrics.com/) or Prometheus (optional, for metrics ingestion)

## Usage

1. **Customize your `values.yaml`** file:

   * Define MSK bootstrap and ZooKeeper hosts.
   * Set your broker capacities (`DISK`, `CPU`, `NW_IN`, `NW_OUT`).
   * Optionally configure UI and metrics ingress.

2. **Install the chart**:

   ```bash
   helm install cruise-control ./path-to-chart -n your-namespace
   ```

3. **Access the UI**:
   Ensure the `ui.ingress.host` and ingress controller are configured. Then open the Cruise Control UI at:

   ```
   https://<your-ui-host>
   ```

4. **Metrics Ingestion**:
   If using VictoriaMetrics, configure `metricsIngress` with rewrite rules and backend service. For Prometheus, you only need to provide the `host`.

## Docker Image

This repository also includes a `Dockerfile` to build your own Cruise Control image. Use this if you wish to:

* Apply custom patches
* Modify Cruise Control configuration
* Use a specific version from source

## Example Configuration Snippet

```yaml
cruiseControl:
  envName: dev
  kafkaClusterName: my-msk-cluster
  image:
    repository: my-dockerhub-user/cruise-control
    tag: v2.5.0-custom
```

## Contribution

Contributions and suggestions from the community are welcome. Please open issues or pull requests if you find improvements or bugs.

---

For further documentation on Cruise Control and its REST API, see the [official docs](https://linkedin.github.io/cruise-control/).
