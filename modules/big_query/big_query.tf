resource "google_bigquery_dataset" "cc_test_dataset" {
  dataset_id    = "inference_data"
  friendly_name = "test to validate tf syntax"
  description   = "This is a test description"
  project       = var.project
  location      = "us-east1"

}

resource "google_bigquery_table" "cc_analytics" {
  dataset_id          = google_bigquery_dataset.cc_test_dataset.dataset_id
  table_id            = "cc_analytics"
  project             = var.project
  deletion_protection = false
  schema              = <<EOF
[
  {
    "name": "recorded_at_EDT",
    "mode": "NULLABLE",
    "type": "TIMESTAMP",
    "description": null,
    "fields": []
  },
  {
    "name": "site",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "station",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "device_id",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "visitor_count_current",
    "mode": "NULLABLE",
    "type": "INTEGER",
    "description": null,
    "fields": []
  },
  {
    "name": "visitor_count_previous",
    "mode": "NULLABLE",
    "type": "INTEGER",
    "description": null,
    "fields": []
  },
  {
    "name": "total_visitors",
    "mode": "NULLABLE",
    "type": "INTEGER",
    "description": null,
    "fields": []
  },
  {
    "name": "wait_time",
    "mode": "NULLABLE",
    "type": "FLOAT",
    "description": null,
    "fields": []
  },
  {
    "name": "region_of_interest",
    "mode": "NULLABLE",
    "type": "INTEGER",
    "description": null,
    "fields": []
  }
]
EOF

}

resource "google_bigquery_table" "cc_inference" {
  dataset_id          = google_bigquery_dataset.cc_test_dataset.dataset_id
  table_id            = "cc_inference"
  project             = var.project
  deletion_protection = false
  schema              = <<EOF
[
  {
    "name": "inference_id",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "site",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "device_id",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "count",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "station",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "recorded_at",
    "mode": "NULLABLE",
    "type": "TIMESTAMP",
    "description": null,
    "fields": []
  },
  {
    "name": "confidence_score",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "object_details",
    "mode": "REPEATED",
    "type": "RECORD",
    "description": null,
    "fields": [
      {
        "name": "body_part",
        "mode": "NULLABLE",
        "type": "STRING",
        "description": null,
        "fields": []
      },
      {
        "name": "x_coordinate",
        "mode": "NULLABLE",
        "type": "STRING",
        "description": null,
        "fields": []
      },
      {
        "name": "y_coordinate",
        "mode": "NULLABLE",
        "type": "STRING",
        "description": null,
        "fields": []
      },
      {
        "name": "body_part_confidence_score",
        "mode": "NULLABLE",
        "type": "STRING",
        "description": null,
        "fields": []
      }
    ]
  }
]
EOF

}

resource "google_bigquery_table" "demo_inference" {
  dataset_id          = google_bigquery_dataset.cc_test_dataset.dataset_id
  table_id            = "demo_inference"
  project             = var.project
  deletion_protection = false
  schema              = <<EOF
[
  {
    "name": "inference_id",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "site",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "device_id",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "visitor_count",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "station",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "recorded_at",
    "mode": "NULLABLE",
    "type": "TIMESTAMP",
    "description": null,
    "fields": []
  },
  {
    "name": "confidence_score",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "object_details",
    "mode": "REPEATED",
    "type": "RECORD",
    "description": null,
    "fields": [
      {
        "name": "body_part",
        "mode": "NULLABLE",
        "type": "STRING",
        "description": null,
        "fields": []
      },
      {
        "name": "x_coordinate",
        "mode": "NULLABLE",
        "type": "STRING",
        "description": null,
        "fields": []
      },
      {
        "name": "y_coordinate",
        "mode": "NULLABLE",
        "type": "STRING",
        "description": null,
        "fields": []
      },
      {
        "name": "body_part_confidence_score",
        "mode": "NULLABLE",
        "type": "STRING",
        "description": null,
        "fields": []
      }
    ]
  }
]
EOF

}

resource "google_bigquery_table" "device_info" {
  dataset_id          = google_bigquery_dataset.cc_test_dataset.dataset_id
  table_id            = "device_info"
  project             = var.project
  deletion_protection = false
  schema              = <<EOF
[
  {
    "name": "device_id",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "mac_address",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "ip",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "port",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "screenshot",
    "mode": "NULLABLE",
    "type": "BOOLEAN",
    "description": null,
    "fields": []
  },
  {
    "name": "station",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  },
  {
    "name": "site",
    "mode": "NULLABLE",
    "type": "STRING",
    "description": null,
    "fields": []
  }
]
EOF

}
