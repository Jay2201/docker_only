import mlflow

# Start an MLflow experiment
experiment = mlflow.set_experiment(experiment_name="mlflow")

print(f"Experiment ID - {experiment.experiment_id}")

with mlflow.start_run(experiment_id=experiment.experiment_id):
    # Log a parameter (key-value pair)
    mlflow.log_param("param1", 5)
    # Log a metric; metrics can be updated throughout the run
    mlflow.log_metric("foo", 1)
    mlflow.log_metric("foo", 2)
    mlflow.log_metric("foo", 3)
