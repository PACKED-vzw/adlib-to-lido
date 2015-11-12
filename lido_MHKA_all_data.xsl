<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">     
        <xsl:template match="/">
            
           
            <lido:lidoWrap xmlns:lido="http://www.lido-schema.org"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.lido-schema.org http://www.lido-schema.org/schema/v1.0/lido-v1.0.xsd">
                <xsl:for-each select="./adlibXML/recordList/record">
                                        
                <lido:lido>
                    <lido:lidoRecID lido:source="PACKED" lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./priref"/></lido:lidoRecID>
                    <lido:objectPublishedID lido:source="MHKA" lido:type="WorkPID" lido:label="WorkPID">[WorkPID]</lido:objectPublishedID>
                    <lido:descriptiveMetadata xml:lang="nl-NL"> 
                        <lido:objectClassificationWrap>
                            <lido:objectWorkTypeWrap>
                                <!-- voor elke Object_name node > een objectWorkType node 
                                    <xsl:choose> is hier belangrijk om te gebruiken, objectWorkType moet verplicht worden ingevuld voor een lido record, 
                                    en als er geen objectnaam werd gedefinieerd door de instelling, moet er toch een  lido:objectWorkType gemaakt worden, maar leeg
                                    export van MHKA was 'unstructured' -> omdat er geen 'nodes' zijn is het ook beter om ipv 'for each' functie 'if' te gebruiken voor 
                                    meerdere occurances   
                                -->
                                <xsl:choose>
                                    <xsl:when test="object_name">
                                        <xsl:if test="object_name[1]">
                                            <lido:objectWorkType>
                                                <!-- <lido:conceptID> kan niet prirefs ingevuld worden omdat ze niet mee in de export zijn meegekomen -->
                                                <lido:term><xsl:value-of select="object_name[1]"/></lido:term>
                                            </lido:objectWorkType>
                                        </xsl:if>
                                        <xsl:if test="object_name[2]">
                                            <lido:objectWorkType>
                                                <!-- <lido:conceptID> kan niet prirefs ingevuld worden omdat ze niet mee in de export zijn meegekomen -->
                                                <lido:term><xsl:value-of select="object_name[2]"/></lido:term>
                                            </lido:objectWorkType>
                                        </xsl:if>
                                        <xsl:if test="object_name[3]">
                                            <lido:objectWorkType>
                                                <!-- <lido:conceptID> kan niet prirefs ingevuld worden omdat ze niet mee in de export zijn meegekomen -->
                                                <lido:term><xsl:value-of select="object_name[3]"/></lido:term>
                                            </lido:objectWorkType>
                                        </xsl:if>
                                        <xsl:if test="object_name[4]">
                                            <lido:objectWorkType>
                                                <!-- <lido:conceptID> kan niet prirefs ingevuld worden omdat ze niet mee in de export zijn meegekomen -->
                                                <lido:term><xsl:value-of select="object_name[4]"/></lido:term>
                                            </lido:objectWorkType>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <lido:objectWorkType>
                                            <lido:term></lido:term>
                                        </lido:objectWorkType>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </lido:objectWorkTypeWrap>
                            <lido:classificationWrap>
                                <!-- voor elke object_category > een classification -->
                                <xsl:if test="object_category[1]">
                                <lido:classification>
                                    <!-- ALINA: object_category.lref was niet mogelijk om mee te nemen -->
                                    <lido:term><xsl:value-of select="object_category[1]"/></lido:term>
                                </lido:classification>
                                </xsl:if>
                                <xsl:if test="object_category[2]">
                                    <lido:classification>
                                        <!-- ALINA: object_category.lref was niet mogelijk om mee te nemen -->
                                        <lido:term><xsl:value-of select="object_category[2]"/></lido:term>
                                    </lido:classification>
                                </xsl:if>
                                <xsl:if test="object_category[3]">
                                    <lido:classification>
                                        <!-- ALINA: object_category.lref was niet mogelijk om mee te nemen -->
                                        <lido:term><xsl:value-of select="object_category[3]"/></lido:term>
                                    </lido:classification>
                                </xsl:if>
                            </lido:classificationWrap>
                        </lido:objectClassificationWrap>
                        <lido:objectIdentificationWrap>
                            <lido:titleWrap>
                                <!-- voor elke Title node > ga ik er vanuit dat er een nederlandstalige titel inzit 
                                ALINA: ik zou het niet doen: default attribute 'xml:lang="nl-NL' verwijdert!-->
                                <xsl:choose>
                                    <xsl:when test="title">
                                        <xsl:if test="title[1]">
                                            <lido:titleSet>
                                                <lido:appellationValue><xsl:value-of select="title[1]"/></lido:appellationValue>
                                            </lido:titleSet>
                                        </xsl:if>
                                        <xsl:if test="title[2]">
                                            <lido:titleSet>
                                                <lido:appellationValue><xsl:value-of select="title[2]"/></lido:appellationValue>
                                            </lido:titleSet>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <lido:titleSet>
                                            <lido:appellationValue></lido:appellationValue>
                                        </lido:titleSet>
                                    </xsl:otherwise>
                                </xsl:choose>        
                                <!--Alina: alle default attributes 'xml:lang="nl-NL/en-US, fr-FR en de-DE' verwijdert! Fase twee: onderzoeken hoe de waarde uit 'title.language' 
                                mappen als een attribute die de taal aangeeft-->
                                <xsl:if test="title.translation[1]">
                                    <lido:titleSet>
                                        <lido:appellationValue><xsl:value-of select="title.translation[1]"/></lido:appellationValue>
                                    </lido:titleSet>
                                </xsl:if>
                                <xsl:if test="title.translation[2]">
                                    <lido:titleSet>
                                        <lido:appellationValue><xsl:value-of select="title.translation[2]"/></lido:appellationValue>
                                    </lido:titleSet>
                                </xsl:if>
                                <xsl:if test="title.translation[3]">
                                    <lido:titleSet>
                                        <lido:appellationValue><xsl:value-of select="title.translation[3]"/></lido:appellationValue>
                                    </lido:titleSet>
                                </xsl:if>
                               
                            </lido:titleWrap>
                            <lido:repositoryWrap>
                                <!--  Heb voor de bewaarinstelling default waarden ingevuld. -->
                                <lido:repositorySet>
                                    <lido:repositoryName>
                                        <lido:legalBodyID lido:type="ISIL">BE-ANN10</lido:legalBodyID>
                                        <lido:legalBodyName>
                                            <lido:appellationValue>Museum van Hedendaagse Kunst Antwerpen (MuHKA)</lido:appellationValue>
                                        </lido:legalBodyName>
                                    </lido:repositoryName>
                                    <lido:workID lido:type="object number"><xsl:value-of select="./object_number"/></lido:workID>
                                </lido:repositorySet>
                            </lido:repositoryWrap>
                        </lido:objectIdentificationWrap>
                         
                        <lido:eventWrap>
                           
                            <!--PRODUCTION
                vervaardiger        Production/creator/name
                toeschrijving       Production/creator.qualifier
                datum van precisie  Production_date/production.date.start.prec
                datum van           Production_date/production.date.start
                datum tot precisie  Production_date/production.date.end.prec
                datum tot           Production_date/production.date.end-->
                            
                            <!-- maak een productie event als er een Production node of een Production_date node is. -->
                            <xsl:if test="creator | production.date.start | production.date.end | production.place">
                                <lido:eventSet>
                                    <lido:event>
                                        <!-- default waarde production -->
                                        <lido:eventType><lido:term>production</lido:term></lido:eventType>
                                        <xsl:if test="creator[1]">
                                            <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <!-- ALINA: creator.lref is niet aanwezig in de export; <lido:actorID> verwijdert -->
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="creator[1]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor>
                                                            <!-- default waarde 'creator' weggedaan en vervangen door creator.role veld in adlib -->
                                                            <lido:term><xsl:value-of select="creator.role[1]"/></lido:term>
                                                        </lido:roleActor>
                                                        <xsl:if test="creator.qualifier[1]">
                                                            <lido:attributionQualifierActor><xsl:value-of select="creator.qualifier[1]"/></lido:attributionQualifierActor>
                                                        </xsl:if>
                                                    </lido:actorInRole>  
                                            </lido:eventActor>
                                        </xsl:if>
                                        <xsl:if test="creator[2]">
                                            <lido:eventActor>
                                                <lido:actorInRole>
                                                    <lido:actor>
                                                        <!-- ALINA: creator.lref is niet aanwezig in de export; <lido:actorID> verwijdert -->
                                                        <lido:nameActorSet>
                                                            <lido:appellationValue><xsl:value-of select="creator[2]"/></lido:appellationValue>
                                                        </lido:nameActorSet>
                                                    </lido:actor>
                                                    <lido:roleActor>
                                                        <!-- default waarde 'creator' weggedaan en vervangen door creator.role veld in adlib -->
                                                        <lido:term><xsl:value-of select="creator.role[2]"/></lido:term>
                                                    </lido:roleActor>
                                                    <xsl:if test="creator.qualifier[2]">
                                                        <lido:attributionQualifierActor><xsl:value-of select="creator.qualifier[2]"/></lido:attributionQualifierActor>
                                                    </xsl:if>
                                                </lido:actorInRole>  
                                            </lido:eventActor>
                                        </xsl:if>
                                        <xsl:if test="creator[3]">
                                            <lido:eventActor>
                                                <lido:actorInRole>
                                                    <lido:actor>
                                                        <!-- ALINA: creator.lref is niet aanwezig in de export; <lido:actorID> verwijdert -->
                                                        <lido:nameActorSet>
                                                            <lido:appellationValue><xsl:value-of select="creator[3]"/></lido:appellationValue>
                                                        </lido:nameActorSet>
                                                    </lido:actor>
                                                    <lido:roleActor>
                                                        <!-- default waarde 'creator' weggedaan en vervangen door creator.role veld in adlib -->
                                                        <lido:term><xsl:value-of select="creator.role[3]"/></lido:term>
                                                    </lido:roleActor>
                                                    <xsl:if test="creator.qualifier[3]">
                                                        <lido:attributionQualifierActor><xsl:value-of select="creator.qualifier[3]"/></lido:attributionQualifierActor>
                                                    </xsl:if>
                                                </lido:actorInRole>  
                                            </lido:eventActor>
                                        </xsl:if>
                                        <xsl:if test="creator[4]">
                                            <lido:eventActor>
                                                <lido:actorInRole>
                                                    <lido:actor>
                                                        <!-- ALINA: creator.lref is niet aanwezig in de export; <lido:actorID> verwijdert -->
                                                        <lido:nameActorSet>
                                                            <lido:appellationValue><xsl:value-of select="creator[4]"/></lido:appellationValue>
                                                        </lido:nameActorSet>
                                                    </lido:actor>
                                                    <lido:roleActor>
                                                        <!-- default waarde 'creator' weggedaan en vervangen door creator.role veld in adlib -->
                                                        <lido:term><xsl:value-of select="creator.role[4]"/></lido:term>
                                                    </lido:roleActor>
                                                    <xsl:if test="creator.qualifier[4]">
                                                        <lido:attributionQualifierActor><xsl:value-of select="creator.qualifier[4]"/></lido:attributionQualifierActor>
                                                    </xsl:if>
                                                </lido:actorInRole>  
                                            </lido:eventActor>
                                        </xsl:if>
                                        
                                        <xsl:if test="production.date.start | production.date.end | production.date.start.prec | production.date.end.prec">
                                            <lido:eventDate>
                                                <lido:displayDate><xsl:value-of select="production.date.start.prec"/>;<xsl:value-of select="production.date.start"/>;<xsl:value-of select="production.date.end.prec"/>;<xsl:value-of select="production.date.end"/></lido:displayDate>
                                                <lido:date>
                                                    <lido:earliestDate></lido:earliestDate>
                                                    <lido:latestDate></lido:latestDate>
                                                </lido:date>
                                            </lido:eventDate>
                                        </xsl:if>
                                        <!-- geen production.place.lref in de export -->
                                        <xsl:if test="production.place">
                                            <lido:eventPlace>
                                                <lido:place>
                                                    <lido:namePlaceSet>
                                                        <lido:appellationValue><xsl:value-of select="production.place"/></lido:appellationValue>
                                                    </lido:namePlaceSet>
                                                </lido:place>
                                            </lido:eventPlace>
                                        </xsl:if>
                                    </lido:event>
                                </lido:eventSet>
                            </xsl:if>
                            
                            <!-- alle events mbt eigendomsgeschiedenis -->
                            
                            <!--databanknummer:   priref
                WorkPID:
                objectnaam      Object_name/object_name/term
                categorie       object_category/term
                titel           Title/title
                                Title_translation/title.translation
                ISIL            (default)
                bewaarinstelling (default)
                objectnummer    object_number
                
                event type      (default)
                verworven van   Acquisition_source/acquisition.source/name
                verworven door  current_owner/name
                datum verwerving    acquisition.date.precision
                                    acquisition.date
                plaats verwerving   acquisition.place
                methode verwerving  acquisition.method
                beschrijving verw.  acquisition.notes
                
                verworven van       owner_hist.acquired_from
                verworven door      owner_hist.owner
                datum verwerving    owner_hist.date.start
                                    owner_hist.date.end
                plaats verwerving   owner_hist.place
                methode verwerving  owner_hist.acquisition.method
                beschrijving verw.  owner_hist.notes
                
                
            -->
                            
                            <xsl:if test="acquisition_source | current_owner | acquisition.date | acquisition.method | acquisition.place | acquisition.notes">
                            <lido:eventSet>
                                    <lido:event>
                                        <lido:eventType>
                                            <!-- default waarde acquisition -->
                                            <lido:term>acquisition</lido:term>
                                        </lido:eventType>
                                        <!-- idereen die 'bron' is van een verwering -->
                                        <xsl:if test="acquisition.source">
                                        <lido:eventActor>
                                            <lido:actorInRole>
                                                <lido:actor>
                                                    <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="acquisition.source.lref"/></lido:actorID>
                                                    <lido:nameActorSet>
                                                        <lido:appellationValue><xsl:value-of select="acquisition.source"/></lido:appellationValue>
                                                    </lido:nameActorSet>
                                                </lido:actor>
                                                <lido:roleActor><lido:term>repeller</lido:term></lido:roleActor>
                                            </lido:actorInRole>
                                        </lido:eventActor>
                                        </xsl:if>               
                                        <!-- idereen die 'doel' is van een verwering -->
                                        <xsl:if test="current_owner">  
                                            <lido:eventActor>
                                                <lido:actorInRole>
                                                    <lido:actor>
                                                        <!-- ALINA: current_owner.lref werkte niet als 'for each' commando wordt gebruikt. we gaan ervan uit dat de current_owner maar een keer wordt ingevuld, dus de for each is ook niet nodig. op die manier werkt lref wel-->
                                                        <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="current_owner.lref"/></lido:actorID>
                                                        <lido:nameActorSet>
                                                            <lido:appellationValue><xsl:value-of select="current_owner"/></lido:appellationValue>
                                                        </lido:nameActorSet>
                                                    </lido:actor>
                                                    <lido:roleActor><lido:term>acquirer</lido:term></lido:roleActor>
                                                </lido:actorInRole>
                                            </lido:eventActor>
                                        </xsl:if>
                                        <xsl:if test="acquisition.date">
                                        <lido:eventDate>
                                            <lido:displayDate><xsl:value-of select="acquisition.date.precision"/>;<xsl:value-of select="acquisition.date"/></lido:displayDate>
                                            <lido:date><lido:earliestDate></lido:earliestDate><lido:latestDate></lido:latestDate></lido:date>
                                        </lido:eventDate>
                                        </xsl:if>    
                                        <xsl:if test="acquisition.place">
                                            <lido:eventPlace>
                                                <lido:place>
                                                    <lido:placeID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="acquisition.place.lref"/></lido:placeID>
                                                    <lido:namePlaceSet>
                                                        <lido:appellationValue><xsl:value-of select="acquisition.place"/></lido:appellationValue>
                                                    </lido:namePlaceSet>
                                                </lido:place>
                                            </lido:eventPlace>
                                        </xsl:if>    
                                        <xsl:if test="acquisition.method">
                                        <lido:eventMethod>
                                            <lido:conceptID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="acquisition.method.lref"/></lido:conceptID>
                                            <lido:term><xsl:value-of select="acquisition.method"/></lido:term>
                                        </lido:eventMethod>
                                        </xsl:if>
                                        <xsl:if test="acquisition.notes">
                                        <lido:eventDescriptionSet>
                                            <lido:descriptiveNoteValue><xsl:value-of select="acquisition.notes"/></lido:descriptiveNoteValue>
                                        </lido:eventDescriptionSet>
                                        </xsl:if>
                                    </lido:event>
                            </lido:eventSet>
                            </xsl:if>
                            
                            <!-- mapping kan max 4 occurrences van owner_hist mappen. voorlopig niet mogelijk om 'alles' mee te nemen. in fase twee een oplossing uitwerken-->
                           
                            <xsl:if test="owner_hist.acquired_from | owner_hist.owner | owner_hist.date.start | owner_hist.date.end | owner_hist.place | owner_hist.acquisition.method | owner_hist.notes">  
                                <xsl:if test="owner_hist.acquired_from[1] | owner_hist.owner[1] | owner_hist.date.start[1] | owner_hist.date.end[1] | owner_hist.place[1] | owner_hist.acquisition.method[1] | owner_hist.notes[1]">  
                                <lido:eventSet>
                                <lido:event>
                                    <lido:eventType>
                                        <!-- default waarde provenance -->
                                        <lido:term>provenance</lido:term>
                                    </lido:eventType>
                                    <!-- iedereen die 'bron' is van een verwering -->
                                    <xsl:if test="owner_hist.acquired_from[1]">
                                            <lido:eventActor>            
                                                <lido:actorInRole>
                                                    <lido:actor>
                                                        <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.acquired_from.lref[1]"/></lido:actorID>
                                                        <lido:nameActorSet>
                                                            <lido:appellationValue><xsl:value-of select="owner_hist.acquired_from[1]"/></lido:appellationValue>
                                                        </lido:nameActorSet>
                                                    </lido:actor>
                                                    <lido:roleActor><lido:term>repeller</lido:term></lido:roleActor>
                                                </lido:actorInRole>
                                            </lido:eventActor>
                                    </xsl:if>
                                    <!-- iedereen die 'doel' is van een verwering -->
                                    <xsl:if test="owner_hist.owner[1]">
                                            <lido:eventActor>
                                                <lido:actorInRole>
                                                    <lido:actor>
                                                        <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.owner.lref[1]"/></lido:actorID>
                                                        <lido:nameActorSet>
                                                            <lido:appellationValue><xsl:value-of select="owner_hist.owner[1]"/></lido:appellationValue>
                                                        </lido:nameActorSet>
                                                    </lido:actor>
                                                    <lido:roleActor><lido:term>acquirer</lido:term></lido:roleActor>
                                                </lido:actorInRole>
                                            </lido:eventActor>
                                    </xsl:if>
                                    <xsl:if test="owner_hist.date.start[1] or owner_hist.date.end[1]">
                                        <lido:eventDate>
                                            <lido:displayDate><xsl:value-of select="owner_hist.date.start[1]"/>;<xsl:value-of select="owner_hist.date.end[1]"/></lido:displayDate>
                                            <lido:date>
                                                <lido:earliestDate></lido:earliestDate>
                                                <lido:latestDate></lido:latestDate>
                                            </lido:date>
                                        </lido:eventDate>
                                    </xsl:if>    
                                    <xsl:if test="owner_hist.place[1]">
                                        <lido:eventPlace>
                                            <lido:place>
                                                <lido:placeID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.place.lref[1]"/></lido:placeID>
                                                <lido:namePlaceSet>
                                                    <lido:appellationValue><xsl:value-of select="owner_hist.place[1]"/></lido:appellationValue>
                                                </lido:namePlaceSet>
                                            </lido:place>
                                        </lido:eventPlace>
                                    </xsl:if>
                                    <xsl:if test="owner_hist.acquisition.method[1]">
                                    <lido:eventMethod>
                                        <lido:conceptID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.acquisition.method.lref[1]"/></lido:conceptID>
                                        <lido:term><xsl:value-of select="owner_hist.acquisition.method[1]"/></lido:term></lido:eventMethod>
                                    </xsl:if>
                                    <xsl:if test="owner_hist.notes[1]">
                                        <lido:eventDescriptionSet>
                                            <lido:descriptiveNoteValue><xsl:value-of select="owner_hist.notes[1]"/></lido:descriptiveNoteValue>
                                        </lido:eventDescriptionSet>
                                    </xsl:if>                                    
                                 </lido:event>
                                </lido:eventSet>
                               </xsl:if>
                                <xsl:if test="owner_hist.acquired_from[2] | owner_hist.owner[2] | owner_hist.date.start[2] | owner_hist.date.end[2] | owner_hist.place[2] | owner_hist.acquisition.method[2] | owner_hist.notes[2]">  
                                    <lido:eventSet>
                                        <lido:event>
                                            <lido:eventType>
                                                <!-- default waarde provenance -->
                                                <lido:term>provenance</lido:term>
                                            </lido:eventType>
                                            <!-- iedereen die 'bron' is van een verwering -->
                                            <xsl:if test="owner_hist.acquired_from[2]">
                                                <lido:eventActor>            
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.acquired_from.lref[2]"/></lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="owner_hist.acquired_from[2]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>repeller</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <!-- iedereen die 'doel' is van een verwering -->
                                            <xsl:if test="owner_hist.owner[2]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.owner.lref[2]"/></lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="owner_hist.owner[2]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>acquirer</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <xsl:if test="owner_hist.date.start[2] or owner_hist.date.end[2]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="owner_hist.date.start[2]"/>;<xsl:value-of select="owner_hist.date.end[2]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>    
                                            <xsl:if test="owner_hist.place[2]">
                                                <lido:eventPlace>
                                                    <lido:place>
                                                        <lido:placeID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.place.lref[2]"/></lido:placeID>
                                                        <lido:namePlaceSet>
                                                            <lido:appellationValue><xsl:value-of select="owner_hist.place[2]"/></lido:appellationValue>
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>
                                            <xsl:if test="owner_hist.acquisition.method[2]">
                                                <lido:eventMethod>
                                                    <lido:conceptID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.acquisition.method.lref[2]"/></lido:conceptID>
                                                    <lido:term><xsl:value-of select="owner_hist.acquisition.method[2]"/></lido:term></lido:eventMethod>
                                            </xsl:if>
                                            <xsl:if test="owner_hist.notes[2]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="owner_hist.notes[2]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>                                    
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="owner_hist.acquired_from[3] | owner_hist.owner[3] | owner_hist.date.start[3] | owner_hist.date.end[3] | owner_hist.place[3] | owner_hist.acquisition.method[3] | owner_hist.notes[3]"> 
                                    <lido:eventSet>
                                        <lido:event>
                                            <lido:eventType>
                                                <lido:term>provenance</lido:term>
                                            </lido:eventType>
                                            <!-- idereen die 'bron' is van een verwering -->
                                            <xsl:if test="owner_hist.acquired_from[3]">
                                                <lido:eventActor>            
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.acquired_from.lref[3]"/></lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="owner_hist.acquired_from[3]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>repeller</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <!-- idereen die 'doel' is van een verwering -->
                                            <xsl:if test="owner_hist.owner[3]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.owner.lref[3]"/></lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="owner_hist.owner[3]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>acquirer</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <xsl:if test="owner_hist.date.start[3] or owner_hist.date.end[3]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="owner_hist.date.start[3]"/>;<xsl:value-of select="owner_hist.date.end[3]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>    
                                            <xsl:if test="owner_hist.place[3]">
                                                <lido:eventPlace>
                                                    <lido:place>
                                                        <lido:placeID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.place.lref[3]"/></lido:placeID>
                                                        <lido:namePlaceSet>
                                                            <lido:appellationValue><xsl:value-of select="owner_hist.place[3]"/></lido:appellationValue>
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>
                                            <xsl:if test="owner_hist.acquisition.method[3]">
                                                <lido:eventMethod>
                                                    <lido:conceptID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.acquisition.method.lref[3]"/></lido:conceptID>
                                                    <lido:term><xsl:value-of select="owner_hist.acquisition.method[3]"/></lido:term>
                                                </lido:eventMethod>
                                            </xsl:if>
                                            <xsl:if test="owner_hist.notes[3]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="owner_hist.notes[3]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>                                    
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>       
                                <xsl:if test="owner_hist.acquired_from[4] | owner_hist.owner[4] | owner_hist.date.start[4] | owner_hist.date.end[4] | owner_hist.place[4] | owner_hist.acquisition.method[4] | owner_hist.notes[4]"> 
                                   <lido:eventSet>
                                       <lido:event>
                                           <lido:eventType>
                                               <lido:term>provenance</lido:term>
                                           </lido:eventType>
                                           <!-- idereen die 'bron' is van een verwering -->
                                           <xsl:if test="owner_hist.acquired_from[4]">
                                               <lido:eventActor>            
                                                   <lido:actorInRole>
                                                       <lido:actor>
                                                           <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.acquired_from.lref[4]"/></lido:actorID>
                                                           <lido:nameActorSet>
                                                               <lido:appellationValue><xsl:value-of select="owner_hist.acquired_from[4]"/></lido:appellationValue>
                                                           </lido:nameActorSet>
                                                       </lido:actor>
                                                       <lido:roleActor><lido:term>repeller</lido:term></lido:roleActor>
                                                   </lido:actorInRole>
                                               </lido:eventActor>
                                           </xsl:if>
                                           <!-- idereen die 'doel' is van een verwering -->
                                           <xsl:if test="owner_hist.owner[4]">
                                               <lido:eventActor>
                                                   <lido:actorInRole>
                                                       <lido:actor>
                                                           <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.owner.lref[4]"/></lido:actorID>
                                                           <lido:nameActorSet>
                                                               <lido:appellationValue><xsl:value-of select="owner_hist.owner[4]"/></lido:appellationValue>
                                                           </lido:nameActorSet>
                                                       </lido:actor>
                                                       <lido:roleActor><lido:term>acquirer</lido:term></lido:roleActor>
                                                   </lido:actorInRole>
                                               </lido:eventActor>
                                           </xsl:if>
                                           <xsl:if test="owner_hist.date.start[4] or owner_hist.date.end[4]">
                                               <lido:eventDate>
                                                   <lido:displayDate><xsl:value-of select="owner_hist.date.start[4]"/>;<xsl:value-of select="owner_hist.date.end[4]"/></lido:displayDate>
                                                   <lido:date>
                                                       <lido:earliestDate></lido:earliestDate>
                                                       <lido:latestDate></lido:latestDate>
                                                   </lido:date>
                                               </lido:eventDate>
                                           </xsl:if>    
                                           <xsl:if test="owner_hist.place[4]">
                                               <lido:eventPlace>
                                                   <lido:place>
                                                       <lido:placeID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.place.lref[4]"/></lido:placeID>
                                                       <lido:namePlaceSet>
                                                           <lido:appellationValue><xsl:value-of select="owner_hist.place[4]"/></lido:appellationValue>
                                                       </lido:namePlaceSet>
                                                   </lido:place>
                                               </lido:eventPlace>
                                           </xsl:if>
                                           <xsl:if test="owner_hist.acquisition.method[4]">
                                               <lido:eventMethod>
                                                   <lido:conceptID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.acquisition.method.lref[4]"/></lido:conceptID>
                                                   <lido:term><xsl:value-of select="owner_hist.acquisition.method[4]"/></lido:term>
                                               </lido:eventMethod>
                                           </xsl:if>
                                           <xsl:if test="owner_hist.notes[4]">
                                               <lido:eventDescriptionSet>
                                                   <lido:descriptiveNoteValue><xsl:value-of select="owner_hist.notes[4]"/></lido:descriptiveNoteValue>
                                               </lido:eventDescriptionSet>
                                           </xsl:if>                                    
                                       </lido:event>
                                   </lido:eventSet>
                               </xsl:if>
                                <xsl:if test="owner_hist.acquired_from[5] | owner_hist.owner[5] | owner_hist.date.start[5] | owner_hist.date.end[5] | owner_hist.place[5] | owner_hist.acquisition.method[5] | owner_hist.notes[5]"> 
                                   <lido:eventSet>
                                       <lido:event>
                                           <lido:eventType>
                                               <lido:term>provenance</lido:term>
                                           </lido:eventType>
                                           <!-- idereen die 'bron' is van een verwering -->
                                           <xsl:if test="owner_hist.acquired_from[5]">
                                               <lido:eventActor>            
                                                   <lido:actorInRole>
                                                       <lido:actor>
                                                           <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.acquired_from.lref[5]"/></lido:actorID>
                                                           <lido:nameActorSet>
                                                               <lido:appellationValue><xsl:value-of select="owner_hist.acquired_from[5]"/></lido:appellationValue>
                                                           </lido:nameActorSet>
                                                       </lido:actor>
                                                       <lido:roleActor><lido:term>repeller</lido:term></lido:roleActor>
                                                   </lido:actorInRole>
                                               </lido:eventActor>
                                           </xsl:if>
                                           <!-- idereen die 'doel' is van een verwering -->
                                           <xsl:if test="owner_hist.owner[5]">
                                               <lido:eventActor>
                                                   <lido:actorInRole>
                                                       <lido:actor>
                                                           <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.owner.lref[5]"/></lido:actorID>
                                                           <lido:nameActorSet>
                                                               <lido:appellationValue><xsl:value-of select="owner_hist.owner[5]"/></lido:appellationValue>
                                                           </lido:nameActorSet>
                                                       </lido:actor>
                                                       <lido:roleActor><lido:term>acquirer</lido:term></lido:roleActor>
                                                   </lido:actorInRole>
                                               </lido:eventActor>
                                           </xsl:if>
                                           <xsl:if test="owner_hist.date.start[5] or owner_hist.date.end[5]">
                                               <lido:eventDate>
                                                   <lido:displayDate><xsl:value-of select="owner_hist.date.start[5]"/>;<xsl:value-of select="owner_hist.date.end[5]"/></lido:displayDate>
                                                   <lido:date>
                                                       <lido:earliestDate></lido:earliestDate>
                                                       <lido:latestDate></lido:latestDate>
                                                   </lido:date>
                                               </lido:eventDate>
                                           </xsl:if>    
                                           <xsl:if test="owner_hist.place[5]">
                                               <lido:eventPlace>
                                                   <lido:place>
                                                       <lido:placeID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.place.lref[5]"/></lido:placeID>
                                                       <lido:namePlaceSet>
                                                           <lido:appellationValue><xsl:value-of select="owner_hist.place[5]"/></lido:appellationValue>
                                                       </lido:namePlaceSet>
                                                   </lido:place>
                                               </lido:eventPlace>
                                           </xsl:if>
                                           <xsl:if test="owner_hist.acquisition.method[5]">
                                               <lido:eventMethod>
                                                   <lido:conceptID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="owner_hist.acquisition.method.lref[5]"/></lido:conceptID>
                                                   <lido:term><xsl:value-of select="owner_hist.acquisition.method[5]"/></lido:term>
                                               </lido:eventMethod>
                                           </xsl:if>
                                           <xsl:if test="owner_hist.notes[5]">
                                               <lido:eventDescriptionSet>
                                                   <lido:descriptiveNoteValue><xsl:value-of select="owner_hist.notes[5]"/></lido:descriptiveNoteValue>
                                               </lido:eventDescriptionSet>
                                           </xsl:if>                                    
                                       </lido:event>
                                   </lido:eventSet>
                               </xsl:if>
                           </xsl:if>
                        
                            <!--EXHIBITION
            
            id              Exhibition/exhibition/reference_number
            titel           Exhibition/exhibition/title
            organisator     Exhibition/exhibition/organiser
            datum start     Exhibition/exhibition/date.start
            datum einde     Exhibition/exhibition/date.end
            locatie         Exhibition/exhibition/venue
            stad            Exhibition/exhibition/venue.place
            
            id              Loan_out/loan.out.number
            titel           Loan_out/loan.out.exhibition
            organisator     Loan_out/loan.out.requester
            datum start     Loan_out/loan.out.request.period.end
            datum einde     Loan_out/loan.out.request.period.start
            notes           Loan_out/loan.out.status
            
            ===>>> lijkt erop dat Exhibition en Loan_out vaak verdubbeling is.
            -->        
                        
                            <!-- een exhibition event voor max 7 exhibitions -->
                            <xsl:if test="exhibition | exhibition.reference_number | exhibition.organiser | exhibition.date.start | exhibition.date.end | exhibition.venue | exhibition.venue.place | exhibition.notes">
                                <xsl:if test="exhibition[1] | exhibition.reference_number[1] | exhibition.organiser[1] | exhibition.date.start[1] | exhibition.date.end[1] | exhibition.venue[1] | exhibition.venue.place[1] | exhibition.notes[1]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- local ID voor tentoonstellingen -->
                                            <lido:eventID lido:type="local"><xsl:value-of select="exhibition.reference_number[1]"/></lido:eventID>
                                            <lido:eventID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="exhibition.lref[1]"/></lido:eventID>
                                            <!-- default waarde exhibition -->
                                            <lido:eventType><lido:term>exhibition</lido:term></lido:eventType>
                                            <!-- titel van de tentoonstelling -->
                                            <lido:eventName>
                                                <lido:appellationValue><xsl:value-of select="exhibition[1]"/></lido:appellationValue>
                                            </lido:eventName>
                                            <!-- organisator -->
                                            <xsl:if test="exhibition.organiser[1]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="exhibition.organiser[1]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>organiser</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <!-- periode van de tentoonstelling -->
                                            <xsl:if test="exhibition.date.start[1] or exhibition.date.end[1]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="exhibition.date.start[1]"/>;<xsl:value-of select="exhibition.date.end[1]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <!-- locatie tentoonstelling: venue en venue.place -->
                                            <xsl:if test="exhibition.venue[1] or exhibition.venue.place[1]">
                                                <lido:eventPlace>
                                                    <lido:place>
                                                        <lido:namePlaceSet>
                                                            <lido:appellationValue><xsl:value-of select="exhibition.venue[1]"/>;<xsl:value-of select="exhibition.venue.place[1]"/></lido:appellationValue>
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>
                                            <xsl:if test="exhibition.notes[1]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="exhibition.notes[1]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="exhibition[2] | exhibition.reference_number[2] | exhibition.organiser[2] | exhibition.date.start[2] | exhibition.date.end[2] | exhibition.venue[2] | exhibition.venue.place[2] | exhibition.notes[2]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- local ID voor tentoonstellingen -->
                                            <lido:eventID lido:type="local"><xsl:value-of select="exhibition.reference_number[2]"/></lido:eventID>
                                            <lido:eventID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="exhibition.lref[2]"/></lido:eventID>
                                            <!-- default waarde exhibition -->
                                            <lido:eventType><lido:term>exhibition</lido:term></lido:eventType>
                                            <!-- titel van de tentoonstelling -->
                                            <lido:eventName>
                                                <lido:appellationValue><xsl:value-of select="exhibition[2]"/></lido:appellationValue>
                                            </lido:eventName>
                                            <!-- organisator -->
                                            <xsl:if test="exhibition.organiser[2]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="exhibition.organiser[2]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>organiser</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <!-- periode van de tentoonstelling -->
                                            <xsl:if test="exhibition.date.start[2] or exhibition.date.end[2]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="exhibition.date.start[2]"/>;<xsl:value-of select="exhibition.date.end[2]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <!-- locatie tentoonstelling: venue en venue.place -->
                                            <xsl:if test="exhibition.venue[2] or exhibition.venue.place[2]">
                                                <lido:eventPlace>
                                                    <lido:place>
                                                        <lido:namePlaceSet>
                                                            <lido:appellationValue><xsl:value-of select="exhibition.venue[2]"/>;<xsl:value-of select="exhibition.venue.place[2]"/></lido:appellationValue>
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>
                                            <xsl:if test="exhibition.notes[2]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="exhibition.notes[2]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="exhibition[3] | exhibition.reference_number[3] | exhibition.organiser[3] | exhibition.date.start[3] | exhibition.date.end[3] | exhibition.venue[3] | exhibition.venue.place[3] | exhibition.notes[3]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- local ID voor tentoonstellingen -->
                                            <lido:eventID lido:type="local"><xsl:value-of select="exhibition.reference_number[3]"/></lido:eventID>
                                            <lido:eventID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="exhibition.lref[3]"/></lido:eventID>
                                            <!-- default waarde exhibition -->
                                            <lido:eventType><lido:term>exhibition</lido:term></lido:eventType>
                                            <!-- titel van de tentoonstelling -->
                                            <lido:eventName>
                                                <lido:appellationValue><xsl:value-of select="exhibition[3]"/></lido:appellationValue>
                                            </lido:eventName>
                                            <!-- organisator -->
                                            <xsl:if test="exhibition.organiser[3]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="exhibition.organiser[3]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>organiser</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <!-- periode van de tentoonstelling -->
                                            <xsl:if test="exhibition.date.start[3] or exhibition.date.end[3]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="exhibition.date.start[3]"/>;<xsl:value-of select="exhibition.date.end[3]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <!-- locatie tentoonstelling: venue en venue.place -->
                                            <xsl:if test="exhibition.venue[3] or exhibition.venue.place[3]">
                                                <lido:eventPlace>
                                                    <lido:place>
                                                        <lido:namePlaceSet>
                                                            <lido:appellationValue><xsl:value-of select="exhibition.venue[3]"/>;<xsl:value-of select="exhibition.venue.place[3]"/></lido:appellationValue>
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>
                                            <xsl:if test="exhibition.notes[3]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="exhibition.notes[3]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="exhibition[4] | exhibition.reference_number[4] | exhibition.organiser[4] | exhibition.date.start[4] | exhibition.date.end[4] | exhibition.venue[4] | exhibition.venue.place[4] | exhibition.notes[4]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- local ID voor tentoonstellingen -->
                                            <lido:eventID lido:type="local"><xsl:value-of select="exhibition.reference_number[4]"/></lido:eventID>
                                            <lido:eventID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="exhibition.lref[4]"/></lido:eventID>
                                            <!-- default waarde exhibition -->
                                            <lido:eventType><lido:term>exhibition</lido:term></lido:eventType>
                                            <!-- titel van de tentoonstelling -->
                                            <lido:eventName>
                                                <lido:appellationValue><xsl:value-of select="exhibition[4]"/></lido:appellationValue>
                                            </lido:eventName>
                                            <!-- organisator -->
                                            <xsl:if test="exhibition.organiser[4]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="exhibition.organiser[4]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>organiser</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <!-- periode van de tentoonstelling -->
                                            <xsl:if test="exhibition.date.start[4] or exhibition.date.end[4]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="exhibition.date.start[4]"/>;<xsl:value-of select="exhibition.date.end[4]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <!-- locatie tentoonstelling: venue en venue.place -->
                                            <xsl:if test="exhibition.venue[4] or exhibition.venue.place[4]">
                                                <lido:eventPlace>
                                                    <lido:place>
                                                        <lido:namePlaceSet>
                                                            <lido:appellationValue><xsl:value-of select="exhibition.venue[4]"/>;<xsl:value-of select="exhibition.venue.place[4]"/></lido:appellationValue>
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>
                                            <xsl:if test="exhibition.notes[4]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="exhibition.notes[4]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="exhibition[5] | exhibition.reference_number[5] | exhibition.organiser[5] | exhibition.date.start[5] | exhibition.date.end[5] | exhibition.venue[5] | exhibition.venue.place[5] | exhibition.notes[5]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- local ID voor tentoonstellingen -->
                                            <lido:eventID lido:type="local"><xsl:value-of select="exhibition.reference_number[5]"/></lido:eventID>
                                            <lido:eventID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="exhibition.lref[5]"/></lido:eventID>
                                            <!-- default waarde exhibition -->
                                            <lido:eventType><lido:term>exhibition</lido:term></lido:eventType>
                                            <!-- titel van de tentoonstelling -->
                                            <lido:eventName>
                                                <lido:appellationValue><xsl:value-of select="exhibition[5]"/></lido:appellationValue>
                                            </lido:eventName>
                                            <!-- organisator -->
                                            <xsl:if test="exhibition.organiser[5]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="exhibition.organiser[5]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>organiser</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <!-- periode van de tentoonstelling -->
                                            <xsl:if test="exhibition.date.start[5] or exhibition.date.end[5]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="exhibition.date.start[5]"/>;<xsl:value-of select="exhibition.date.end[5]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <!-- locatie tentoonstelling: venue en venue.place -->
                                            <xsl:if test="exhibition.venue[5] or exhibition.venue.place[5]">
                                                <lido:eventPlace>
                                                    <lido:place>
                                                        <lido:namePlaceSet>
                                                            <lido:appellationValue><xsl:value-of select="exhibition.venue[5]"/>;<xsl:value-of select="exhibition.venue.place[5]"/></lido:appellationValue>
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>
                                            <xsl:if test="exhibition.notes[5]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="exhibition.notes[2]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="exhibition[6] | exhibition.reference_number[6] | exhibition.organiser[6] | exhibition.date.start[6] | exhibition.date.end[6] | exhibition.venue[6] | exhibition.venue.place[6] | exhibition.notes[6]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- local ID voor tentoonstellingen -->
                                            <lido:eventID lido:type="local"><xsl:value-of select="exhibition.reference_number[6]"/></lido:eventID>
                                            <lido:eventID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="exhibition.lref[6]"/></lido:eventID>
                                            <!-- default waarde exhibition -->
                                            <lido:eventType><lido:term>exhibition</lido:term></lido:eventType>
                                            <!-- titel van de tentoonstelling -->
                                            <lido:eventName>
                                                <lido:appellationValue><xsl:value-of select="exhibition[6]"/></lido:appellationValue>
                                            </lido:eventName>
                                            <!-- organisator -->
                                            <xsl:if test="exhibition.organiser[6]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="exhibition.organiser[6]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>organiser</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <!-- periode van de tentoonstelling -->
                                            <xsl:if test="exhibition.date.start[6] or exhibition.date.end[6]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="exhibition.date.start[6]"/>;<xsl:value-of select="exhibition.date.end[6]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <!-- locatie tentoonstelling: venue en venue.place -->
                                            <xsl:if test="exhibition.venue[6] or exhibition.venue.place[6]">
                                                <lido:eventPlace>
                                                    <lido:place>
                                                        <lido:namePlaceSet>
                                                            <lido:appellationValue><xsl:value-of select="exhibition.venue[6]"/>;<xsl:value-of select="exhibition.venue.place[6]"/></lido:appellationValue>
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>
                                            <xsl:if test="exhibition.notes[6]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="exhibition.notes[6]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="exhibition[7] | exhibition.reference_number[7] | exhibition.organiser[7] | exhibition.date.start[7] | exhibition.date.end[7] | exhibition.venue[7] | exhibition.venue.place[7] | exhibition.notes[7]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- local ID voor tentoonstellingen -->
                                            <lido:eventID lido:type="local"><xsl:value-of select="exhibition.reference_number[7]"/></lido:eventID>
                                            <lido:eventID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="exhibition.lref[7]"/></lido:eventID>
                                            <!-- default waarde exhibition -->
                                            <lido:eventType><lido:term>exhibition</lido:term></lido:eventType>
                                            <!-- titel van de tentoonstelling -->
                                            <lido:eventName>
                                                <lido:appellationValue><xsl:value-of select="exhibition[7]"/></lido:appellationValue>
                                            </lido:eventName>
                                            <!-- organisator -->
                                            <xsl:if test="exhibition.organiser[7]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="exhibition.organiser[7]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>organiser</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <!-- periode van de tentoonstelling -->
                                            <xsl:if test="exhibition.date.start[7] or exhibition.date.end[7]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="exhibition.date.start[7]"/>;<xsl:value-of select="exhibition.date.end[7]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <!-- locatie tentoonstelling: venue en venue.place -->
                                            <xsl:if test="exhibition.venue[7] or exhibition.venue.place[7]">
                                                <lido:eventPlace>
                                                    <lido:place>
                                                        <lido:namePlaceSet>
                                                            <lido:appellationValue><xsl:value-of select="exhibition.venue[7]"/>;<xsl:value-of select="exhibition.venue.place[7]"/></lido:appellationValue>
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>
                                            <xsl:if test="exhibition.notes[7]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="exhibition.notes[7]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                            </xsl:if>
                            
                            <!-- een exhibition event voor max 7 bruiklenen. -->
                            <xsl:if test="loan.out.number | loan.out.exhibition | loan.out.requester | loan.out.contract.period.start | loan.out.contract.period.end | loan.out.status | loan.out.requester.contact">
                                <xsl:if test="loan.out.number[1] | loan.out.exhibition[1] | loan.out.requester[1] | loan.out.contract.period.start[1] | loan.out.contract.period.end[1] | loan.out.status[1] | loan.out.requester.contact[1]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- local ID voor bruiklenen -->
                                            <xsl:if test="loan.out.number[1]">
                                            <lido:eventID lido:type="local loan ID"><xsl:value-of select="loan.out.number[1]"/></lido:eventID>
                                            <lido:eventID lido:type="local loan ID" lido:label="Adlib database number"><xsl:value-of select="loan.out.number.lref[1]"/></lido:eventID>
                                            </xsl:if>
                                             <!-- default waarde exhibition -->
                                            <lido:eventType><lido:term>exhibition</lido:term></lido:eventType>
                                            <xsl:if test="loan.out.exhibition[1]">
                                            <lido:eventName>
                                                <lido:appellationValue><xsl:value-of select="loan.out.exhibition[1]"/></lido:appellationValue>
                                            </lido:eventName>
                                            </xsl:if>    
                                            <!-- organisator -->
                                            <xsl:if test="loan.out.requester[1] or loan.out.requester.contact[1]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="loan.out.requester[1]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="loan.out.requester.contact[1]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>organiser</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            
                                            <!-- periode van de tentoonstelling=periode bruikleen -->
                                            <xsl:if test="loan.out.contract.period.start[1] or loan.out.contract.period.end[1]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="loan.out.contract.period.start[1]"/>;<xsl:value-of select="loan.out.contract.period.end[1]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <xsl:if test="loan.out.status[1]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="loan.out.status[1]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="loan.out.number[2] | loan.out.exhibition[2] | loan.out.requester[2] | loan.out.contract.period.start[2] | loan.out.contract.period.end[2] | loan.out.status[2] | loan.out.requester.contact[2]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- local ID voor bruiklenen -->
                                            <xsl:if test="loan.out.number[2]">
                                                <lido:eventID lido:type="local loan ID"><xsl:value-of select="loan.out.number[2]"/></lido:eventID>
                                                <lido:eventID lido:type="local loan ID" lido:label="Adlib database number"><xsl:value-of select="loan.out.number.lref[2]"/></lido:eventID>
                                            </xsl:if>
                                            <!-- default waarde exhibition -->
                                            <lido:eventType><lido:term>exhibition</lido:term></lido:eventType>
                                            <xsl:if test="loan.out.exhibition[2]">
                                                <lido:eventName>
                                                    <lido:appellationValue><xsl:value-of select="loan.out.exhibition[2]"/></lido:appellationValue>
                                                </lido:eventName>
                                            </xsl:if>    
                                            <!-- organisator -->
                                            <xsl:if test="loan.out.requester[2] or loan.out.requester.contact[2]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="loan.out.requester[2]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="loan.out.requester.contact[2]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>organiser</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            
                                            <!-- periode van de tentoonstelling=periode bruikleen -->
                                            <xsl:if test="loan.out.contract.period.start[2] or loan.out.contract.period.end[2]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="loan.out.contract.period.start[2]"/>;<xsl:value-of select="loan.out.contract.period.end[2]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <xsl:if test="loan.out.status[2]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="loan.out.status[2]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="loan.out.number[3] | loan.out.exhibition[3] | loan.out.requester[3] | loan.out.contract.period.start[3] | loan.out.contract.period.end[3] | loan.out.status[3] | loan.out.requester.contact[3]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- local ID voor bruiklenen -->
                                            <xsl:if test="loan.out.number[3]">
                                                <lido:eventID lido:type="local loan ID"><xsl:value-of select="loan.out.number[3]"/></lido:eventID>
                                                <lido:eventID lido:type="local loan ID" lido:label="Adlib database number"><xsl:value-of select="loan.out.number.lref[3]"/></lido:eventID>
                                            </xsl:if>
                                            <!-- default waarde exhibition -->
                                            <lido:eventType><lido:term>exhibition</lido:term></lido:eventType>
                                            <xsl:if test="loan.out.exhibition[3]">
                                                <lido:eventName>
                                                    <lido:appellationValue><xsl:value-of select="loan.out.exhibition[3]"/></lido:appellationValue>
                                                </lido:eventName>
                                            </xsl:if>    
                                            <!-- organisator -->
                                            <xsl:if test="loan.out.requester[3] or loan.out.requester.contact[3]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="loan.out.requester[3]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="loan.out.requester.contact[3]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>organiser</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            
                                            <!-- periode van de tentoonstelling=periode bruikleen -->
                                            <xsl:if test="loan.out.contract.period.start[3] or loan.out.contract.period.end[3]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="loan.out.contract.period.start[3]"/>;<xsl:value-of select="loan.out.contract.period.end[3]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <xsl:if test="loan.out.status[3]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="loan.out.status[3]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="loan.out.number[4] | loan.out.exhibition[4] | loan.out.requester[4] | loan.out.contract.period.start[4] | loan.out.contract.period.end[4] | loan.out.status[4] | loan.out.requester.contact[4]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- local ID voor bruiklenen -->
                                            <xsl:if test="loan.out.number[4]">
                                                <lido:eventID lido:type="local loan ID"><xsl:value-of select="loan.out.number[4]"/></lido:eventID>
                                                <lido:eventID lido:type="local loan ID" lido:label="Adlib database number"><xsl:value-of select="loan.out.number.lref[4]"/></lido:eventID>
                                            </xsl:if>
                                            <!-- default waarde exhibition -->
                                            <lido:eventType><lido:term>exhibition</lido:term></lido:eventType>
                                            <xsl:if test="loan.out.exhibition[4]">
                                                <lido:eventName>
                                                    <lido:appellationValue><xsl:value-of select="loan.out.exhibition[4]"/></lido:appellationValue>
                                                </lido:eventName>
                                            </xsl:if>    
                                            <!-- organisator -->
                                            <xsl:if test="loan.out.requester[4] or loan.out.requester.contact[4]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="loan.out.requester[4]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="loan.out.requester.contact[4]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>organiser</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            
                                            <!-- periode van de tentoonstelling=periode bruikleen -->
                                            <xsl:if test="loan.out.contract.period.start[4] or loan.out.contract.period.end[4]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="loan.out.contract.period.start[4]"/>;<xsl:value-of select="loan.out.contract.period.end[4]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <xsl:if test="loan.out.status[4]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="loan.out.status[4]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="loan.out.number[5] | loan.out.exhibition[5] | loan.out.requester[5] | loan.out.contract.period.start[5] | loan.out.contract.period.end[5] | loan.out.status[5] | loan.out.requester.contact[5]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- local ID voor bruiklenen -->
                                            <xsl:if test="loan.out.number[5]">
                                                <lido:eventID lido:type="local loan ID"><xsl:value-of select="loan.out.number[5]"/></lido:eventID>
                                                <lido:eventID lido:type="local loan ID" lido:label="Adlib database number"><xsl:value-of select="loan.out.number.lref[5]"/></lido:eventID>
                                            </xsl:if>
                                            <!-- default waarde exhibition -->
                                            <lido:eventType><lido:term>exhibition</lido:term></lido:eventType>
                                            <xsl:if test="loan.out.exhibition[5]">
                                                <lido:eventName>
                                                    <lido:appellationValue><xsl:value-of select="loan.out.exhibition[5]"/></lido:appellationValue>
                                                </lido:eventName>
                                            </xsl:if>    
                                            <!-- organisator -->
                                            <xsl:if test="loan.out.requester[5] or loan.out.requester.contact[5]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="loan.out.requester[5]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="loan.out.requester.contact[5]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>organiser</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            
                                            <!-- periode van de tentoonstelling=periode bruikleen -->
                                            <xsl:if test="loan.out.contract.period.start[5] or loan.out.contract.period.end[5]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="loan.out.contract.period.start[5]"/>;<xsl:value-of select="loan.out.contract.period.end[5]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <xsl:if test="loan.out.status[5]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="loan.out.status[5]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="loan.out.number[6] | loan.out.exhibition[6] | loan.out.requester[6] | loan.out.contract.period.start[6] | loan.out.contract.period.end[6] | loan.out.status[6] | loan.out.requester.contact[6]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- local ID voor bruiklenen -->
                                            <xsl:if test="loan.out.number[6]">
                                                <lido:eventID lido:type="local loan ID"><xsl:value-of select="loan.out.number[6]"/></lido:eventID>
                                                <lido:eventID lido:type="local loan ID" lido:label="Adlib database number"><xsl:value-of select="loan.out.number.lref[6]"/></lido:eventID>
                                            </xsl:if>
                                            <!-- default waarde exhibition -->
                                            <lido:eventType><lido:term>exhibition</lido:term></lido:eventType>
                                            <xsl:if test="loan.out.exhibition[6]">
                                                <lido:eventName>
                                                    <lido:appellationValue><xsl:value-of select="loan.out.exhibition[6]"/></lido:appellationValue>
                                                </lido:eventName>
                                            </xsl:if>    
                                            <!-- organisator -->
                                            <xsl:if test="loan.out.requester[6] or loan.out.requester.contact[6]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="loan.out.requester[6]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="loan.out.requester.contact[6]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>organiser</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            
                                            <!-- periode van de tentoonstelling=periode bruikleen -->
                                            <xsl:if test="loan.out.contract.period.start[6] or loan.out.contract.period.end[6]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="loan.out.contract.period.start[6]"/>;<xsl:value-of select="loan.out.contract.period.end[6]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <xsl:if test="loan.out.status[6]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="loan.out.status[6]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="loan.out.number[7] | loan.out.exhibition[7] | loan.out.requester[7] | loan.out.contract.period.start[7] | loan.out.contract.period.end[7] | loan.out.status[7] | loan.out.requester.contact[7]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- local ID voor bruiklenen -->
                                            <xsl:if test="loan.out.number[7]">
                                                <lido:eventID lido:type="local loan ID"><xsl:value-of select="loan.out.number[7]"/></lido:eventID>
                                                <lido:eventID lido:type="local loan ID" lido:label="Adlib database number"><xsl:value-of select="loan.out.number.lref[7]"/></lido:eventID>
                                            </xsl:if>
                                            <!-- default waarde exhibition -->
                                            <lido:eventType><lido:term>exhibition</lido:term></lido:eventType>
                                            <xsl:if test="loan.out.exhibition[7]">
                                                <lido:eventName>
                                                    <lido:appellationValue><xsl:value-of select="loan.out.exhibition[7]"/></lido:appellationValue>
                                                </lido:eventName>
                                            </xsl:if>    
                                            <!-- organisator -->
                                            <xsl:if test="loan.out.requester[7] or loan.out.requester.contact[7]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="loan.out.requester[7]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="loan.out.requester.contact[7]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>organiser</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            
                                            <!-- periode van de tentoonstelling=periode bruikleen -->
                                            <xsl:if test="loan.out.contract.period.start[7] or loan.out.contract.period.end[7]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="loan.out.contract.period.start[7]"/>;<xsl:value-of select="loan.out.contract.period.end[7]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <xsl:if test="loan.out.status[7]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="loan.out.status[7]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                            </xsl:if>
                            
                            <!--Publication
            ID              Documentation/documentation.title.lref
            auteur          Documentation/documentation.author
            titel           Documentation/documentation.title
            pagina          Documentation.documentation.page_reference (todo volgende fase?)
            -->
                            
                            <!-- een publication event voor max 5 documentations -->
                            <xsl:if test="documentation.title | documentation.author | documentation.notes">
                                <xsl:if test="documentation.title[1] | documentation.author[1] | documentation.notes[1]">
                                    <lido:eventSet> 
                                        <lido:event>
                                            <!-- local ID voor publicaties in de Adlib Bibliotheek catalogus -->
                                            <xsl:if test="documentation.title.lref[1]">
                                                <lido:eventID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="documentation.title.lref[1]"/></lido:eventID>
                                            </xsl:if>
                                            <!-- default waarde publication -->
                                            <lido:eventType><lido:term>publication</lido:term></lido:eventType>
                                            <!-- titel van de publicatie -->
                                            <xsl:if test="documentation.title[1]">
                                            <lido:eventName>
                                                <lido:appellationValue><xsl:value-of select="documentation.title[1]"/></lido:appellationValue>
                                            </lido:eventName>
                                            </xsl:if>
                                            <!-- organisator -->
                                            <xsl:if test="documentation.author[1]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="documentation.author[1]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>author</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <xsl:if test="documentation.notes[1]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="documentation.notes[1]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="documentation.title[2] | documentation.author[2] | documentation.notes[2]">
                                    <lido:eventSet> 
                                        <lido:event>
                                            <!-- local ID voor publicaties in de Adlib Bibliotheek catalogus -->
                                            <xsl:if test="documentation.title.lref[2]">
                                                <lido:eventID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="documentation.title.lref[2]"/></lido:eventID>
                                            </xsl:if>
                                            <!-- default waarde publication -->
                                            <lido:eventType><lido:term>publication</lido:term></lido:eventType>
                                            <!-- titel van de publicatie -->
                                            <xsl:if test="documentation.title[2]">
                                                <lido:eventName>
                                                    <lido:appellationValue><xsl:value-of select="documentation.title[2]"/></lido:appellationValue>
                                                </lido:eventName>
                                            </xsl:if>
                                            <!-- organisator -->
                                            <xsl:if test="documentation.author[2]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="documentation.author[2]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>author</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <xsl:if test="documentation.notes[2]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="documentation.notes[2]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="documentation.title[3] | documentation.author[3] | documentation.notes[3]">
                                    <lido:eventSet> 
                                        <lido:event>
                                            <!-- local ID voor publicaties in de Adlib Bibliotheek catalogus -->
                                            <xsl:if test="documentation.title.lref[3]">
                                                <lido:eventID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="documentation.title.lref[3]"/></lido:eventID>
                                            </xsl:if>
                                            <!-- default waarde publication -->
                                            <lido:eventType><lido:term>publication</lido:term></lido:eventType>
                                            <!-- titel van de publicatie -->
                                            <xsl:if test="documentation.title[3]">
                                                <lido:eventName>
                                                    <lido:appellationValue><xsl:value-of select="documentation.title[3]"/></lido:appellationValue>
                                                </lido:eventName>
                                            </xsl:if>
                                            <!-- organisator -->
                                            <xsl:if test="documentation.author[3]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="documentation.author[3]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>author</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <xsl:if test="documentation.notes[3]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="documentation.notes[3]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="documentation.title[4] | documentation.author[4] | documentation.notes[4]">
                                    <lido:eventSet> 
                                        <lido:event>
                                            <!-- local ID voor publicaties in de Adlib Bibliotheek catalogus -->
                                            <xsl:if test="documentation.title.lref[4]">
                                                <lido:eventID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="documentation.title.lref[4]"/></lido:eventID>
                                            </xsl:if>
                                            <!-- default waarde publication -->
                                            <lido:eventType><lido:term>publication</lido:term></lido:eventType>
                                            <!-- titel van de publicatie -->
                                            <xsl:if test="documentation.title[4]">
                                                <lido:eventName>
                                                    <lido:appellationValue><xsl:value-of select="documentation.title[4]"/></lido:appellationValue>
                                                </lido:eventName>
                                            </xsl:if>
                                            <!-- organisator -->
                                            <xsl:if test="documentation.author[4]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="documentation.author[4]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>author</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <xsl:if test="documentation.notes[4]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="documentation.notes[4]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="documentation.title[5] | documentation.author[5] | documentation.notes[5]">
                                    <lido:eventSet> 
                                        <lido:event>
                                            <!-- local ID voor publicaties in de Adlib Bibliotheek catalogus -->
                                            <xsl:if test="documentation.title.lref[5]">
                                                <lido:eventID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="documentation.title.lref[5]"/></lido:eventID>
                                            </xsl:if>
                                            <!-- default waarde publication -->
                                            <lido:eventType><lido:term>publication</lido:term></lido:eventType>
                                            <!-- titel van de publicatie -->
                                            <xsl:if test="documentation.title[5]">
                                                <lido:eventName>
                                                    <lido:appellationValue><xsl:value-of select="documentation.title[5]"/></lido:appellationValue>
                                                </lido:eventName>
                                            </xsl:if>
                                            <!-- organisator -->
                                            <xsl:if test="documentation.author[5]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="documentation.author[5]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>author</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <xsl:if test="documentation.notes[5]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="documentation.notes[5]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                            </xsl:if>
                            
                            <!-- een condition assessment event voor max 4  condition checks. -->
                            <xsl:if test="condition | condition.check.name | condition.date | condition.notes">
                                <xsl:if test="condition[1] | condition.check.name[1] | condition.date[1] | condition.notes[1]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- wat is de ID van een Condition Check? voorlopig een default waarde-->
                                            <lido:eventID lido:type="?"></lido:eventID>
                                            <!-- default waarde condition assessment E14 volgens Cidoc-CRM http://www.cidoc-crm.org/html/5.0.4/cidoc-crm.html#E14-->
                                            <lido:eventType><lido:term>condition assessment</lido:term></lido:eventType>
                                            <!-- label van de check -->
                                            <lido:eventName>
                                                <lido:appellationValue><xsl:value-of select="condition[1]"/></lido:appellationValue>
                                            </lido:eventName>
                                            <!-- uitvoerder van de condition check -->
                                            <xsl:if test="condition.check.name[1]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="condition.check.name[1]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>condition inspector</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <xsl:if test="condition.date[1]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="condition.date[1]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate><lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <xsl:if test="condition.notes[1]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="condition.notes[1]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="condition[2] | condition.check.name[2] | condition.date[2] | condition.notes[2]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- wat is de ID van een Condition Check? voorlopig een default waarde-->
                                            <lido:eventID lido:type="?"></lido:eventID>
                                            <!-- default waarde condition assessment E14 volgens Cidoc-CRM http://www.cidoc-crm.org/html/5.0.4/cidoc-crm.html#E14-->
                                            <lido:eventType><lido:term>condition assessment</lido:term></lido:eventType>
                                            <!-- label van de check -->
                                            <lido:eventName>
                                                <lido:appellationValue><xsl:value-of select="condition[2]"/></lido:appellationValue>
                                            </lido:eventName>
                                            <!-- uitvoerder van de condition check -->
                                            <xsl:if test="condition.check.name[2]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="condition.check.name[2]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>condition inspector</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <xsl:if test="condition.date[2]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="condition.date[2]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate><lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <xsl:if test="condition.notes[2]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="condition.notes[2]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="condition[3] | condition.check.name[3] | condition.date[3] | condition.notes[3]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- wat is de ID van een Condition Check? voorlopig een default waarde-->
                                            <lido:eventID lido:type="?"></lido:eventID>
                                            <!-- default waarde condition assessment E14 volgens Cidoc-CRM http://www.cidoc-crm.org/html/5.0.4/cidoc-crm.html#E14-->
                                            <lido:eventType><lido:term>condition assessment</lido:term></lido:eventType>
                                            <!-- label van de check -->
                                            <lido:eventName>
                                                <lido:appellationValue><xsl:value-of select="condition[3]"/></lido:appellationValue>
                                            </lido:eventName>
                                            <!-- uitvoerder van de condition check -->
                                            <xsl:if test="condition.check.name[3]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="condition.check.name[3]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>condition inspector</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <xsl:if test="condition.date[3]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="condition.date[3]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate><lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <xsl:if test="condition.notes[3]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="condition.notes[3]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                                <xsl:if test="condition[4] | condition.check.name[4] | condition.date[4] | condition.notes[4]">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- wat is de ID van een Condition Check? voorlopig een default waarde-->
                                            <lido:eventID lido:type="?"></lido:eventID>
                                            <!-- default waarde condition assessment E14 volgens Cidoc-CRM http://www.cidoc-crm.org/html/5.0.4/cidoc-crm.html#E14-->
                                            <lido:eventType><lido:term>condition assessment</lido:term></lido:eventType>
                                            <!-- label van de check -->
                                            <lido:eventName>
                                                <lido:appellationValue><xsl:value-of select="condition[4]"/></lido:appellationValue>
                                            </lido:eventName>
                                            <!-- uitvoerder van de condition check -->
                                            <xsl:if test="condition.check.name[4]">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="condition.check.name[4]"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>condition inspector</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <xsl:if test="condition.date[4]">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="condition.date[4]"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate><lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            <xsl:if test="condition.notes[4]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="condition.notes[4]"/></lido:descriptiveNoteValue>
                                                </lido:eventDescriptionSet>
                                            </xsl:if>
                                        </lido:event>
                                    </lido:eventSet>
                                </xsl:if>
                            </xsl:if>
                            
                            
                        </lido:eventWrap>
                    </lido:descriptiveMetadata>
                    <lido:administrativeMetadata xml:lang="nl-NL">
                        <lido:recordWrap>
                            <lido:recordID lido:type="local"><xsl:value-of select="./priref"/></lido:recordID>
                            <lido:recordType>
                                <lido:term>item</lido:term>
                            </lido:recordType>
                            <lido:recordSource>
                                <lido:legalBodyName>
                                    <lido:appellationValue>Museum van Hedendaagse Kunst Antwerpen (MuHKA)</lido:appellationValue>
                                </lido:legalBodyName>
                            </lido:recordSource>
                        </lido:recordWrap>
                    </lido:administrativeMetadata>
                </lido:lido>

                </xsl:for-each>

            </lido:lidoWrap>
        </xsl:template>
</xsl:stylesheet>