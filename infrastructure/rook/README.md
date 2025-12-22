# 🗄️ Ceph (Rook) Cluster — Current Status

This document summarizes the **current operational state** of the Ceph cluster managed by Rook in this repository. It reflects **live cluster output** and intentionally documents known warnings and trade-offs.

*Last updated: based on live `ceph status` output*

---

## 📌 Cluster Overview

* **Ceph ID:** `a41a2a21-fb6f-4add-b92a-c262f8c7a739`
* **Operator:** Rook (`rook-ceph`)
* **Deployment:** Flux + Helm (`rook-ceph` and `rook-ceph-cluster`)
* **Primary use:** Kubernetes PersistentVolumes (RBD)
* **Environment:** Homelab / development

---

## 🧱 Current Topology

| Component    | Status                                     |
| ------------ | ------------------------------------------ |
| MONs         | 3 (co-located on one node, quorum healthy) |
| MGR          | 1 active                                   |
| MDS          | 1 active, 1 standby                        |
| OSDs         | 1 (`osd.0` on `worker1`, NVMe-backed)      |
| StorageClass | `ceph-block` (default)                     |

---

## 💾 OSD Layout

```
root=default
└── host=worker1
    └── osd.0 (nvme, up+in)
```

* Single OSD backed by a dedicated NVMe disk
* Disk is fully owned by Ceph (Bluestore)
* No shared usage with Talos OS

---

## 📦 Block Pool Configuration

### ceph-blockpool

* **Type:** Replicated
* **Replication size:** `1`
* **Safe replica enforcement:** Disabled (`requireSafeReplicaSize: false`)
* **Status:** `Ready`
* **Failure domain:** `host`

This configuration is **intentional** and required because the cluster currently has **only one OSD**.

---

## 📦 StorageClasses

| Name              | Provisioner | Default | Expansion |
| ----------------- | ----------- | ------- | --------- |
| `ceph-block`      | RBD CSI     | ✅       | ✅         |
| `ceph-filesystem` | CephFS CSI  | ❌       | ✅         |
| `ceph-bucket`     | RGW         | ❌       | ❌         |

All PVCs default to `ceph-block` unless otherwise specified.

---

## ⚠️ Cluster Health: HEALTH_WARN (Expected)

The cluster currently reports **HEALTH_WARN**. This is **expected and understood**, given the intentional single-OSD design.

### Reported warnings

* OSD count 1 < osd_pool_default_size 3
* Placement groups undersized / inactive
* Reduced data redundancy
* Pools with no replicas
* Slow MDS metadata IOs

### Why this is expected

* Ceph defaults to a replication size of **3**
* The cluster has **1 OSD**
* Global defaults are overridden to allow operation, but some system pools created earlier still reflect the mismatch
* No data integrity issues are present for the current workload

Despite the warnings:

* **At least one pool is active and clean**
* **PVC provisioning works**
* **Bound volumes are healthy and usable**

---

## ✅ What Is Working

* Rook operator and Ceph daemons are healthy
* OSD is up and in
* Block pool is `Ready`
* StorageClass is functional
* PVCs bind successfully
* Active workloads persist data correctly

---

## ❌ What Is NOT Provided (By Design)

This cluster **does not provide**:

* High availability
* Data redundancy
* Fault tolerance against disk or node failure

A failure of the OSD disk or node **will result in data loss**. This is an explicit and accepted trade-off for this environment.

---

## 📈 Scaling Plan

The cluster is intentionally minimal but designed to scale cleanly.

Planned upgrade path:

1. Add additional disks and/or nodes
2. Bring new OSDs to `up + in`
3. Increase pool replication size (`size: 2` → `3`)
4. Allow Ceph to rebalance data

No reinstall or data migration tooling is required to scale.


