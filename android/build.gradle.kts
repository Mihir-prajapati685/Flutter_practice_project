buildscript {
    val kotlinVersion = "1.8.0"
    repositories {
        google()   // Required for Google dependencies
        mavenCentral()
        jcenter()  // Optional, but useful
    }
    dependencies {
        classpath("com.google.gms:google-services:4.4.2")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
        jcenter()
    }
}

val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)

    project.evaluationDependsOn(":app") // Moved inside
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
