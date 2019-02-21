pipeline {

    agent any

    stages {
        stage('prepare') {
            steps {
                sh "haxelib newrepo"
                sh "haxelib git arp_ci https://github.com/ArpEngine/Arp-ci master --always"
                sh "haxelib run arp_ci sync"
            }
        }

        stage('flash') {
            steps {
                sh "ARPCI_PROJECT=ArpEngine ARPCI_TARGET=swf ARPCI_BACKEND=flash haxelib run arp_ci test"
            }
        }

        stage('flash_heaps') {
            steps {
                sh "ARPCI_PROJECT=ArpEngine ARPCI_TARGET=swf ARPCI_BACKEND=heaps haxelib run arp_ci test"
            }
        }

        stage('js') {
            steps {
                sh "ARPCI_PROJECT=ArpEngine ARPCI_TARGET=js ARPCI_BACKEND=js haxelib run arp_ci test"
            }
        }

        stage('js_heaps') {
            steps {
                sh "ARPCI_PROJECT=ArpEngine ARPCI_TARGET=js ARPCI_BACKEND=heaps haxelib run arp_ci test"
            }
        }
    }

    post {
        always {
            junit(
                    allowEmptyResults: true,
                    keepLongStdio: true,
                    healthScaleFactor: 2.0,
                    testResults: 'bin/report/*.xml'
            )
        }
    }
}
