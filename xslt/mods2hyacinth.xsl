<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:mods="http://www.loc.gov/mods/v3" version="1.1">
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        <dynamic_field_data>
            <xsl:apply-templates/>
        </dynamic_field_data>
    </xsl:template>

    <!-- title -->

    <xsl:template match="mods:mods/mods:titleInfo">
        <title>
            <xsl:apply-templates select="mods:title"/>
        </title>
    </xsl:template>
    <xsl:template match="mods:title">
        <title_sort_portion>
            <xsl:apply-templates/>
        </title_sort_portion>
    </xsl:template>

    <!-- abstract -->

    <xsl:template match="mods:abstract">
        <abstract>
            <abstract_value>
                <xsl:apply-templates select="./text()"/>
            </abstract_value>
        </abstract>
    </xsl:template>

    <!-- dates -->

    <xsl:template match="mods:originInfo">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="mods:dateCreated">
        <date_created_textual>
            <date_created_textual>
                <xsl:apply-templates/>
            </date_created_textual>
        </date_created_textual>
    </xsl:template>

    <xsl:template match="mods:dateCreated[@encoding][@point = 'start']">
        <date_created>
            <date_created_start_value>
                <xsl:apply-templates/>
            </date_created_start_value>
        </date_created>
    </xsl:template>


    <xsl:template match="mods:dateCreated[@encoding][@point = 'end']">
        <date_created>
            <date_created_end_value>
                <xsl:apply-templates/>
            </date_created_end_value>
        </date_created>
    </xsl:template>


    <xsl:template match="mods:dateOther">
        <date_other_textual>
            <date_other_textual>
                <xsl:apply-templates/>
            </date_other_textual>
        </date_other_textual>
    </xsl:template>

    <xsl:template match="mods:dateOther[@encoding][@point = 'start']">
        <date_other>
            <date_other_start_value>
                <xsl:apply-templates/>
            </date_other_start_value>
        </date_other>
    </xsl:template>


    <xsl:template match="mods:dateOther[@encoding][@point = 'end']">
        <date_other>
            <date_other_end_value>
                <xsl:apply-templates/>
            </date_other_end_value>
        </date_other>
    </xsl:template>

    <!-- names -->

    <xsl:template match="mods:name">
        <name>
            <name_term>
                <xsl:call-template name="term_data">
                    <xsl:with-param name="value" select="normalize-space(mods:namePart)"/>
                </xsl:call-template>
            </name_term>
            <xsl:apply-templates select="@type"/>
            <xsl:apply-templates select="mods:role"/>
        </name>
    </xsl:template>

    <xsl:template match="mods:name/@type">
        <name_type>
            <xsl:value-of select="normalize-space()"/>
        </name_type>
    </xsl:template>
    <xsl:template match="mods:role">
        <name_role>
            <xsl:apply-templates select="mods:roleTerm"/>
        </name_role>
    </xsl:template>
    <xsl:template match="mods:roleTerm">
        <name_role_term>
            <xsl:call-template name="term_data"/>
        </name_role_term>
    </xsl:template>


    <!-- subjects -->

    <xsl:template match="mods:subject">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="mods:topic">
        <subject_topic>
            <subject_topic_term>
                <xsl:call-template name="term_data"/>
            </subject_topic_term>
        </subject_topic>
    </xsl:template>

    <xsl:template match="mods:geographic">
        <subject_geographic>
            <subject_geographic_term>
                <xsl:call-template name="term_data"/>
            </subject_geographic_term>
        </subject_geographic>
    </xsl:template>

<!-- NAMES AS SUBJECTS HAVE OWN TERMS; NEED SPECIAL PROCESSING -->

<xsl:template match="mods:subject/mods:name">
    <subject_name>
        <subject_name_term>
            <xsl:call-template name="term_data">
                <xsl:with-param name="value" select="normalize-space(mods:namePart)"/>
            </xsl:call-template>
        </subject_name_term>
        <subject_name_type>
            <xsl:value-of select="normalize-space()"/>
        </subject_name_type>
    </subject_name>
</xsl:template>


    <!-- language -->

    <xsl:template match="mods:language">
        <language>
            <xsl:apply-templates/>
        </language>
    </xsl:template>

    <xsl:template match="mods:languageTerm">
        <language_term>
            <xsl:call-template name="term_data"/>
        </language_term>
    </xsl:template>


    <!-- location -->
    <xsl:template match="mods:location">
        <location>
            <xsl:apply-templates/>
        </location>
    </xsl:template>

    <xsl:template match="mods:physicalLocation">
        <location_term>
            <xsl:call-template name="term_data"/>
        </location_term>
    </xsl:template>

    <xsl:template match="mods:url[@access = 'object in context']">
        <object_in_context_url_value>
            <xsl:apply-templates select="./text()"/>
        </object_in_context_url_value>
    </xsl:template>

    <!-- form -->
    <xsl:template match="mods:physicalDescription">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="mods:form">
        <form>
            <form_term>
                <xsl:call-template name="term_data"/>
            </form_term>
        </form>
    </xsl:template>

    <!-- extent -->
    <xsl:template match="mods:extent">
        <extent>
            <extent_value>
                <xsl:apply-templates select="./text()"/>
            </extent_value>
        </extent>
    </xsl:template>

    <!-- typeOfResource-->

    <xsl:template match="mods:typeOfResource">
        <type_of_resource>
            <type_of_resource_value>
                <xsl:apply-templates select="text()"/>
            </type_of_resource_value>
        </type_of_resource>
    </xsl:template>

    <!-- digital origin -->

    <xsl:template match="mods:digitalOrigin">
        <digital_origin>
            <digital_origin_value>
                <xsl:apply-templates select="text()"/>
            </digital_origin_value>
        </digital_origin>
    </xsl:template>


    <!-- note -->
    <xsl:template match="mods:note">
        <note>
            <note_value>
                <xsl:apply-templates select="./text()"/>
            </note_value>
            <note_type>
                <xsl:apply-templates select="./text()"/>
            </note_type>
        </note>
    </xsl:template>

    <!-- authority attributes -->

    <xsl:template match="@valueURI">
        <uri>
            <xsl:value-of select="normalize-space()"/>
        </uri>
    </xsl:template>
    <xsl:template match="@authority">
        <authority>
            <xsl:value-of select="normalize-space()"/>
        </authority>
    </xsl:template>

    <xsl:template name="term_data">
        <xsl:param name="value"/>
        <xsl:apply-templates select="@valueURI | @authority"/>
        <value>
            <xsl:choose>
                <xsl:when test="normalize-space($value)">
                    <xsl:value-of select="$value"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="normalize-space()"/>
                </xsl:otherwise>
            </xsl:choose>
        </value>
    </xsl:template>




    <!-- do not process -->

    <xsl:template match="mods:relatedItem"/>

    <!-- not processed -->

    <xsl:template match="*">
        <xsl:message>
            <xsl:text>NOT CONVERTED: </xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text> : </xsl:text>
            <xsl:value-of select="normalize-space(./text())"/>
        </xsl:message>
        <xsl:apply-templates select="child::*"/>
    </xsl:template>



</xsl:stylesheet>
