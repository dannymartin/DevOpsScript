# install JDK 
yum -y install java-1.8.0-openjdk wget && rm -rf /var/cache/yum

# ==========================================
# Install from yum
#echo "Installing EPEL, python-pip, unzip, libaio, oci_cli, requests, cx_Oracle"
#yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#yum -y install python-pip
#yum -y install unzip
#yum -y install libaio 
#yum -y install nodejs npm --enablerepo=epel
#yum -y install git
#yum -y install nano
#yum clean all

# install from pip
#echo 'installing oci_cli, requests, cx_Oracle'
#pip install oci_cli requests cx_Oracle

# ==========================================
# Setup oracle instant client and sqlcl
#ENV SQLPLUS oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm
#ENV SQLCL sqlcl-18*.zip
#ENV INSTANT_CLIENT oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm

# Make directories
mkdir -p /opt/oracle/lib
cd /opt/oracle/lib
#echo "Installing instant client........" && \
#   rpm -ivh ${INSTANT_CLIENT} && \
#   echo "Installing SQL*Plus..........." && \
#   rpm -ivh ${SQLPLUS} && \
#   unzip ${SQLCL} && \
#   rm ${INSTANT_CLIENT} ${SQLPLUS} ${SQLCL} && \
mkdir -p /opt/oracle/database/wallet
mkdir -p /opt/oracle/tools/oci

#set env variables ****************** Take second look at
#export ORACLE_BASE=/opt/oracle/lib/instantclient_12_2
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.2/client64/lib/:$LD_LIBRARY_PATH
#export TNS_ADMIN=/opt/oracle/database/wallet/
#export ORACLE_HOME=/opt/oracle/lib/instantclient_12_2
#export PATH=$PATH:/usr/lib/oracle/12.2/client64/bin:/opt/oracle/lib/sqlcl/bin

# ==========================================
# install node app
mkdir -p /opt/oracle/tools/nodejs/sdk && mkdir -p /opt/oracle/tools/nodejs/apps
# Get the ATPConnectionTest node app
cd /opt/oracle/tools/nodejs/apps
git clone https://github.com/kbhanush/ATPConnectionTest
mv ATPConnectionTest/* .
rm -r ATPConnectionTest
#EXPOSE 3050

# =========================================
# Setup terraform
mkdir -p /opt/oracle/tools/terraform
cd /opt/oracle/tools/terraform
wget https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip
unzip terraform_0.11.10_linux_amd64.zip
mv terraform /usr/local/bin/ 
rm terraform_0.11.10_linux_amd64.zip
git clone https://github.com/dannymartin/ATPTerraform.git
mv ATPTerraform/* . 
rm -r ATPTerraform


# ==========================================
# install Sample apps - Java SDK sample 
mkdir -p /opt/oracle/tools/java/sdk
export JAVA_APP=/opt/oracle/tools/java/sdk
cd /opt/oracle/tools/java/sdk
wget --content-disposition https://github.com/dannymartin/ATPJava/blob/master/ATPJava.zip?raw=true
unzip ATPJava.zip
rm ATPJava.zip
mkdir lib
wget http://central.maven.org/maven2/info/picocli/picocli/3.6.1/picocli-3.6.1.jar -P lib
export PATH=$PATH:$JAVA_APP/bin

# install Java SDK 
# lib/ contains libraries & third-party/lib contains dependencies
cd $JAVA_APP
git clone https://github.com/oracle/oci-java-sdk/releases/download/v1.2.47/oci-java-sdk.zip
mkdir java-sdk
mv oci-java-sdk.zip java-sdk
cd java-sdk
unzip oci-java-sdk.zip
mv lib/*.jar ../lib
mv third-party/lib/*.jar ../lib
cd ..
rm -rf java-sdk

# install Java JDBC
export JDBC_DIR=$JAVA_APP/lib
cd $JDBC_DIR
wget --content-disposition https://github.com/dannymartin/ojdbc8-full/blob/master/ojdbc8-full.tar.gz?raw=true
tar xvzf ojdbc8-full.tar.gz
mv ojdbc8-full/* .


# ==========================================
# Python SDK sample app, also setup for OCI-CLI bash scripts
mkdir -p /opt/oracle/tools/python/sdk
cd /opt/oracle/tools/python/sdk
git clone https://github.com/dannymartin/ATPPython.git
mv ATPPython/python/sdk/* .
mv ATPPython/oci/* /opt/oracle/tools/oci/
mkdir ../apps
mv exampleConnection.py sales.csv ../apps
rm -r ATPPython

# ==========================================
# Node REST calls sample app
cd /opt/oracle/tools/nodejs/sdk
git clone https://github.com/kbhanush/ATP-REST-nodejs.git
mv ATP-REST-nodejs/* .
rm -r ATP-REST-nodejs
node -v
npm -v 
npm install -g oracledb http-signature jssha 
npm install


# Uninstall packages
echo "============================"
echo "You are in /opt/oracle/tools"   
cd /opt/oracle/tools


