default['webdeploymenttoolkit']['WebDeployExe'] = "\"%programfiles%\\IIS\\Microsoft Web Deploy V3\\msdeploy.exe\""
if (File.exist?("%PROGRAMFILES%\\IIS\\Microsoft Web Deploy V2\\msdeploy.exe"))
  default['webdeploymenttoolkit']['WebDeployExe'] = "%programfiles%\\IIS\\Microsoft Web Deploy V2\\msdeploy.exe\""
end
