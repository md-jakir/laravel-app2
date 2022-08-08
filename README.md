# APP2 LARAVEL DEPLOYMENT IN KUBERNETES CLUSTER
For the laravel application here, I use latest composer and PHP 7.4 image. Firstly I've installed composer in my host machine and generate a project using composer. 
Then I got the souce code and modified as per my need. To get the mentioed output I've created route in web.php file under routes direcroty like below.

                    Route::get('/app2', function () {
                        return view('app1');
                    });

And create a app1.blad.php file as followkng in resources/views location

                    <!DOCTYPE html>
                    <html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
                    <h3> Hello I am App 2 </h3>
                    </html>

Here, first portion of the blad.php file called app1 should match with route /app1. 
# Build image and push 
When I done then create Dockerfile and docker compose file to build the image. To build the image and push to docker hub I use jenkins pipeline. To do this need to install neccessary plugins in jenkins. I'll get docker.build, docker.withRegistry options when we install docker plugins in jenkins. With jenksing pipline I build image and push to my docker hub and tagging the image with ${BUILD_NUBMER} jenkins variable. I create a jenkins credential using docker hub username and password to access the docker hub for pushing image.

# Deploying in Kubernetes Cluster
To deploy the image create a deployment manifest file and adding deploy stage in jenkins pipeline. First I need to install kubernetes, kubernetes-cli, kubernetes credential and other supported plugins. For this stage need to create another jenkins creadentail for accessing kubernetes endpoint. To create this credential I use kube config file as a authentication and use this credential ID in pipeline syntax. Here, I define TAG_NAME variable for ${BUILD_NUMBER} and use it as image tag in manifest file.
