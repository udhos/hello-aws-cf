#!/bin/bash

sg_name=sg-name-here
sg_res=$(echo $sg_name | sed -e s/-//g)
vpc_id=vpc-id-here
cidrs=cidrs.txt
ports=ports.txt
out=sg.yaml

[ -f $cidrs ] || { echo >&2 "$0: missing file: $cidrs"; exit 1; }
[ -f $ports ] || { echo >&2 "$0: missing file: $ports"; exit 1; }

header() {

cat <<__EOF__
AWSTemplateFormatVersion: 2010-09-09

Resources: 
  $sg_res:
    Type: AWS::EC2::SecurityGroup
    Properties:
      VpcId: $vpc_id
      GroupDescription: $sg_name
      Tags:
        -
         Key: Name
         Value: $sg_name
      SecurityGroupIngress:
__EOF__

}

rule() {
	local proto="$1"
	local port="$2"
	local cidr="$3"

cat <<__EOF__
        - IpProtocol: $proto
          FromPort: $port
          ToPort: $port
          CidrIp: $cidr
__EOF__
}

header > $out

cat "$cidrs" | while read c; do
	cat "$ports" | while read p; do
		rule tcp $p $c
		i=$(($i+1))
	done
done >> $out

echo >&2 \# "$0: sg=$sg_name ($sg_res) vpc=$vpc_id output: $out"

