from django.db import models

class Certificate(models.Model):
    # Unique identifier for the certificate owner (e.g., student ID)
    certificate_id = models.CharField(max_length=100, unique=True)
    # Name of the certificate holder
    name = models.CharField(max_length=255)
    # The unique hash provided by IPFS
    ipfs_hash = models.CharField(max_length=60, unique=True)
    # Date the certificate was issued
    issue_date = models.DateField()

    def __str__(self):
        return f"{self.name} - {self.certificate_id}"