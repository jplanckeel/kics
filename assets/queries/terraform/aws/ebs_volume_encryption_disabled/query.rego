package Cx

import data.generic.common as common_lib
import data.generic.terraform as tf_lib

CxPolicy[result] {
	doc := input.document[i]
	resource := doc.resource.aws_ebs_volume[name]
	not common_lib.valid_key(resource, "encrypted")

	result := {
		"documentId": doc.id,
		"resourceType": "aws_ebs_volume",
		"resourceName": tf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("aws_ebs_volume[%s]", [name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "One of 'aws_ebs_volume.encrypted' is defined",
		"keyActualValue": "One of 'aws_ebs_volume.encrypted' is undefined",
	}
}

CxPolicy[result] {
	doc := input.document[i]
	resource := doc.resource.aws_ebs_volume[name]
	resource.encrypted == false

	result := {
		"documentId": doc.id,
		"resourceType": "aws_ebs_volume",
		"resourceName": tf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("aws_ebs_volume[%s].encrypted", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": "One of 'aws_ebs_volume.encrypted' is 'true'",
		"keyActualValue": "One of 'aws_ebs_volume.encrypted' is 'false'",
	}
}
