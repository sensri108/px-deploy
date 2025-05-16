# Stork Backups

Deploys a cluster with Portworx, MinIO and Petclinic

# Supported Environments

* Any

# Requirements

## Deploy the template

It is a best practice to use your initials or name as part of the name of the deployment in order to make it easier for others to see the ownership of the deployment in the AWS console.

```
px-deploy create -t backup-restore -n <my-deployment-name>
```

# Demo Workflow

1. Obtain the external IP for the cluster:

```
px-deploy status -n <my-deployment-name>
```

2. Open a browser tab fand go to http://<ip:30333>.

3. Connect to the deployment in a terminal.

4. Show it is a Kubernetes and Portworx cluster:

```
kubectl get nodes
pxctl status
```

5. Go to your browser. Click Find Owners, Add Owner and populate the form with some dummy data and then click Add Owner. Click Find Owners and Find Owner, and show that there is the entry at the bottom of the list.

6. In the terminal, show the BackupLocation YAML that is to be applied:

```
cat /assets/backup-restore/backupLocation.yml
```

Mention that the BackupLocation is in the `petclinic` namespace which means we can use it to backup only that namespace. If we were to create it in the `kube-system` namespace, we would be able to backup any namespace. Talk about it being an S3 target with standard S3 parameters. Note the `sync: true` parameter and say we will come back to it later.

7. Apply the BackupLocation object:

```
kubectl apply -f /assets/backup-restore/backupLocation.yml
```

8. In the terminal, show the ApplicationBackup YAML that is to be applied:

```
cat /assets/backup-restore/applicationBackup.yml
```

Mention that the ApplicationBackup is in the `petclinic` namespace which means we can use it to migrate only that namespace. If we were to create it in the `kube-system` namespace, we would be able to backup any namespace.

9. Apply the ApplicationBackup object:

```
kubectl apply -f /assets/backup-restore/applicationBackup.yml
```

10. Show the ApplicationBackup object:

```
kubectl get applicationbackup -n petclinic
storkctl get applicationbackup -n petclinic
```

Do not continue until the ApplicationBackup has succeeded.

11. Delete the `petclinic` namespace:

```
kubectl delete ns petclinic
```

Refresh the browser to prove the application no longer exists.

12. Recreate the `petclinic` namespace, along with the BackupLocation object:

```
kubectl create ns petclinic
kubectl apply -f /assets/backup-restore/backupLocation.yml
```

Watch for the ApplicationBackup objects to be recreated automatically:

```
watch storkctl get applicationbackups -n petclinic
```

Go back to the `sync: true` parameter we discussed earlier. This is triggering Stork to communicate with the S3 bucket defined in the BackupLocation to pull the metadata associcated with the backup that we took earlier. Once it has retrieved that metadata, it will create an ApplicationBackup object to abstract it. Wait for that object to appear in the output. Copy the name of the object to the clipboard.

13. Edit `/assets/backup-restore/applicationRestore.yml`. Talk about the `backupLocation` object referencing the BackupLocation we just created. Paste the name of the ApplicationBackup object we just found into the `backupName` parameter. Save and exit.

14. Apply the ApplicationRestore object:

```
kubectl apply -f /assets/backup-restore/applicationRestore.yml
```

15. Monitor the status of the restore:

```
watch storkctl get applicationrestores -n petclinic
```

16. Show the application has been restored:

```
kubectl get all,pvc -n petclinic
```

17. Show the pods starting:

```
kubectl get pod -n petclinic
```

18. Refresh the browser tab. Click Find Owners and Find Owner and show the data is still there.
