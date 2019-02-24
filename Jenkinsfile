pipeline {

    agent any

    stages {
        stage('prepare') {
            steps {
                githubNotify(context: 'swf', description: '', status: 'PENDING');
                githubNotify(context: 'swf_heaps', description: '', status: 'PENDING');
                githubNotify(context: 'js', description: '', status: 'PENDING');
                githubNotify(context: 'js_heaps', description: '', status: 'PENDING');
                sh "haxelib newrepo"
                sh "haxelib git arp_ci https://github.com/ArpEngine/Arp-ci master --always"
                sh "HAXELIB_PATH=`pwd`/.haxelib haxelib run arp_ci sync"
            }
        }

        stage('swf') {
            steps {
                sh "HAXELIB_PATH=`pwd`/.haxelib ARPCI_PROJECT=ArpEngine ARPCI_TARGET=swf ARPCI_BACKEND=flash haxelib run arp_ci test"
            }
            post {
                success { githubNotify(context: "${STAGE_NAME}", description: '', status: 'SUCCESS'); }
                unsuccessful { githubNotify(context: "${STAGE_NAME}", description: '', status: 'FAILURE'); }
            }
        }

        stage('swf_heaps') {
            steps {
                sh "HAXELIB_PATH=`pwd`/.haxelib ARPCI_PROJECT=ArpEngine ARPCI_TARGET=swf ARPCI_BACKEND=heaps haxelib run arp_ci test"
            }
            post {
                success { githubNotify(context: "${STAGE_NAME}", description: '', status: 'SUCCESS'); }
                unsuccessful { githubNotify(context: "${STAGE_NAME}", description: '', status: 'FAILURE'); }
            }
        }

        stage('js') {
            steps {
                sh "HAXELIB_PATH=`pwd`/.haxelib ARPCI_PROJECT=ArpEngine ARPCI_TARGET=js ARPCI_BACKEND=js haxelib run arp_ci test"
            }
            post {
                success { githubNotify(context: "${STAGE_NAME}", description: '', status: 'SUCCESS'); }
                unsuccessful { githubNotify(context: "${STAGE_NAME}", description: '', status: 'FAILURE'); }
            }
        }

        stage('js_heaps') {
            steps {
                sh "HAXELIB_PATH=`pwd`/.haxelib ARPCI_PROJECT=ArpEngine ARPCI_TARGET=js ARPCI_BACKEND=heaps haxelib run arp_ci test"
            }
            post {
                success { githubNotify(context: "${STAGE_NAME}", description: '', status: 'SUCCESS'); }
                unsuccessful { githubNotify(context: "${STAGE_NAME}", description: '', status: 'FAILURE'); }
            }
        }
    }

    post {
        always { junit(testResults: 'bin/report/*.xml', keepLongStdio: true); }
    }
}
