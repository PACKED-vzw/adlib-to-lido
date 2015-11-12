<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">     
        <xsl:template match="/">
            
           
            <lido:lidoWrap xmlns:lido="http://www.lido-schema.org"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.lido-schema.org http://www.lido-schema.org/schema/v1.0/lido-v1.0.xsd">
                <xsl:for-each select="./adlibXML/recordList/record">
                    <lido:lido>
                        <lido:lidoRecID lido:source="PACKED" lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./priref"/></lido:lidoRecID>
                        <lido:objectPublishedID lido:source="SMAK" lido:type="WorkPID" lido:label="WorkPID">[WorkPID]</lido:objectPublishedID>
                        <lido:descriptiveMetadata xml:lang="nl-NL">
                            <lido:objectClassificationWrap>
                                <lido:objectWorkTypeWrap>
                                    <!-- voor elke Object_name node > een objectWorkType node 
                                    <xsl:choose> is hier belangrijk om te gebruiken, objectWorkType moet verplicht worden ingevuld voor een lido record, 
                                    en als er geen objectnaam werd gedefinieerd door de instelling, moet er toch een  lido:objectWorkType gemaakt worden, maar leeg
                                    -->
                                    <xsl:choose>
                                        <xsl:when test="./Object_name">
                                            <xsl:for-each select="./Object_name">
                                                <lido:objectWorkType>
                                                    <lido:conceptID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./object_name.lref"/></lido:conceptID>
                                                    <lido:term><xsl:value-of select="./object_name/term"/></lido:term>
                                                </lido:objectWorkType>
                                            </xsl:for-each>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <lido:objectWorkType>
                                                <lido:term></lido:term>
                                            </lido:objectWorkType>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </lido:objectWorkTypeWrap>
                                <lido:classificationWrap>
                                    <!-- voor elke object_category > een classification node -->
                                    <xsl:for-each select="./object_category">
                                        <lido:classification>
                                            <!-- ALINA: voor lido:conceptID moet de waarde van object_category.lref gemapped worden. Fase 2: hoe attributes mappen? -->
                                            <lido:term><xsl:value-of select="./term"/></lido:term>
                                        </lido:classification>
                                    </xsl:for-each>
                                </lido:classificationWrap>
                        </lido:objectClassificationWrap>
                            <lido:objectIdentificationWrap>
                                <lido:titleWrap>
                                    <!-- voor elke Title node > ga ik er vanuit dat er een nederlandstalige titel inzit 
                                ALINA: ik zou het niet doen: default attribute 'xml:lang="nl-NL' verwijdert!-->
                                    <xsl:choose>
                                        <xsl:when test="./Title">
                                            <xsl:for-each select="./Title">
                                                <lido:titleSet>
                                                    <lido:appellationValue><xsl:value-of select="./title"/></lido:appellationValue>
                                                </lido:titleSet>
                                            </xsl:for-each>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <lido:titleSet>
                                                <lido:appellationValue></lido:appellationValue>
                                            </lido:titleSet>
                                        </xsl:otherwise>
                                        
                                    </xsl:choose>        
                                    <!-- voor elke Title_translation node > ga ik er vanuit dat er een engelstalige titel inzit. Maar ik zie ook heel wat lege nodes. Navragen bij Guenevere.
                                Alina: alle default attributes 'xml:lang="nl-NL/en-US, fr-FR en de-DE' verwijdert! Fase twee: onderzoeken hoe de waarde uit 'title.language' 
                                mappen als een attribute die de taal aangeeft-->
                                    <xsl:if test="./Titel_translation[1]/title.translation">    
                                        <lido:titleSet>
                                            <lido:appellationValue><xsl:value-of select="./Titel_translation[1]/title.translation"/></lido:appellationValue>
                                        </lido:titleSet>
                                    </xsl:if>
                                    <xsl:if test="./Titel_translation[2]/title.translation">    
                                        <lido:titleSet>
                                            <lido:appellationValue><xsl:value-of select="./Titel_translation[2]/title.translation"/></lido:appellationValue>
                                        </lido:titleSet>
                                    </xsl:if>
                                    <xsl:if test="./Titel_translation[3]/title.translation">
                                        <lido:titleSet>
                                            <lido:appellationValue><xsl:value-of select="./Titel_translation[3]/title.translation"/></lido:appellationValue>
                                        </lido:titleSet>
                                    </xsl:if>
                                </lido:titleWrap>
                                <lido:repositoryWrap>
                                    <!--  Heb voor de bewaarinstelling default waarden ingevuld. -->
                                    <lido:repositorySet>
                                        <lido:repositoryName>
                                            <lido:legalBodyID lido:type="ISIL">BE-GET05</lido:legalBodyID>
                                            <lido:legalBodyName>
                                                <lido:appellationValue>S.M.A.K.</lido:appellationValue>
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
                datum tot           Production_date/production.date.end
                plaats              Production/production.place 
                   -->
                            
                            
                                <!-- maak een productie event als er een Production node of een Production_date node is. -->
                                <xsl:if test="Production | Production_date">
                                    <lido:eventSet>
                                        <lido:event>
                                            <!-- default waarde production -->
                                            <lido:eventType><lido:term>production</lido:term></lido:eventType>
                                            <!-- Elke Production node komt overeen met 1 vervaardiger -->
                                            <xsl:for-each select="./Production">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./creator.lref"/></lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="./creator/name"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor>
                                                            <!-- default waarde 'creator' weggedaan en vervangen door creator.role veld in adlib -->
                                                            <lido:term><xsl:value-of select="./creator.role"/></lido:term>
                                                        </lido:roleActor>
                                                        <xsl:if test="./creator.qualifier">
                                                            <lido:attributionQualifierActor><xsl:value-of select="./creator.qualifier"/></lido:attributionQualifierActor>
                                                        </xsl:if>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:for-each>
                                            <!-- er is maar 1 Production_date node -->
                                            <xsl:if test="Production_date">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="./Production_date/production.date.start.prec"/>;<xsl:value-of select="./Production_date/production.date.start"/>;<xsl:value-of select="./Production_date/production.date.end.prec"/>;<xsl:value-of select="./Production_date/production.date.end"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>
                                            
                                            <xsl:if test="./production.place"> 
                                                <lido:eventPlace> 
                                                    <lido:place>  
                                                        <lido:placeID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./production.place.lref"/></lido:placeID> 
                                                        <lido:namePlaceSet> 
                                                            <lido:appellationValue><xsl:value-of select="./production.place"/></lido:appellationValue> 
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
                            
                                <xsl:if test="Acquisition_source | current_owner | acquisition.date | acquisition.method | acquisition.place | acquisition.notes">
                                    <lido:eventSet>
                                        <lido:event>
                                            <lido:eventType>
                                                <!-- default waarde acquisition -->
                                                <lido:term>acquisition</lido:term>
                                            </lido:eventType>
                                            <!-- idereen die 'bron' is van een verwering -->
                                            <xsl:for-each select="./Acquisition_source">
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="acquisition.source.lref"/></lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="./acquisition.source/name"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>repeller</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:for-each>               
                                            <!-- idereen die 'doel' is van een verwering -->
                                            <xsl:if test="current_owner">  
                                                <lido:eventActor>
                                                    <lido:actorInRole>
                                                        <lido:actor>
                                                            <!-- ALINA: current_owner.lref werkte niet als 'for each' commando wordt gebruikt. we gaan ervan uit dat de current_owner maar een keer wordt ingevuld, dus de for each is ook niet nodig. op die manier werkt lref wel-->
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="current_owner.lref"/></lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="./current_owner/name"/></lido:appellationValue>
                                                            </lido:nameActorSet>
                                                        </lido:actor>
                                                        <lido:roleActor><lido:term>acquirer</lido:term></lido:roleActor>
                                                    </lido:actorInRole>
                                                </lido:eventActor>
                                            </xsl:if>
                                            <xsl:if test="acquisition.date">
                                                <lido:eventDate>
                                                    <lido:displayDate><xsl:value-of select="./acquisition.date.precision"/>;<xsl:value-of select="./acquisition.date"/></lido:displayDate>
                                                    <lido:date>
                                                        <lido:earliestDate></lido:earliestDate>
                                                        <lido:latestDate></lido:latestDate>
                                                    </lido:date>
                                                </lido:eventDate>
                                            </xsl:if>    
                                            <xsl:if test="acquisition.place">
                                                <lido:eventPlace>
                                                    <lido:place>
                                                        <lido:placeID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./acquisition.place.lref"/></lido:placeID>
                                                        <lido:namePlaceSet>
                                                            <lido:appellationValue><xsl:value-of select="./acquisition.place"/></lido:appellationValue>
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>    
                                            <xsl:if test="acquisition.method">
                                                <lido:eventMethod>
                                                    <lido:conceptID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./acquisition.method.lref"/></lido:conceptID>
                                                    <lido:term><xsl:value-of select="./acquisition.method"/></lido:term>
                                                </lido:eventMethod>
                                            </xsl:if>
                                            <xsl:if test="acquisition.notes">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="./acquisition.notes"/></lido:descriptiveNoteValue>
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
                                                        <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.acquired_from.lref[1]"/></lido:actorID>
                                                        <lido:nameActorSet>
                                                            <lido:appellationValue><xsl:value-of select="./owner_hist.acquired_from[1]/name"/></lido:appellationValue>
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
                                                        <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.owner.lref[1]"/></lido:actorID>
                                                        <lido:nameActorSet>
                                                            <lido:appellationValue><xsl:value-of select="./owner_hist.owner[1]/name"/></lido:appellationValue>
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
                                                <lido:placeID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.place.lref[1]"/></lido:placeID>
                                                <lido:namePlaceSet>
                                                    <lido:appellationValue><xsl:value-of select="./owner_hist.place[1]/term"/></lido:appellationValue>
                                                </lido:namePlaceSet>
                                            </lido:place>
                                        </lido:eventPlace>
                                    </xsl:if>
                                    <xsl:if test="owner_hist.acquisition.method[1]">
                                    <lido:eventMethod>
                                        <lido:conceptID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.acquisition.method.lref[1]"/></lido:conceptID>
                                        <lido:term><xsl:value-of select="./owner_hist.acquisition.method[1]/term"/></lido:term></lido:eventMethod>
                                    </xsl:if>
                                    <xsl:if test="owner_hist.notes[1]">
                                        <lido:eventDescriptionSet>
                                            <lido:descriptiveNoteValue><xsl:value-of select="./owner_hist.notes[1]"/></lido:descriptiveNoteValue>
                                        </lido:eventDescriptionSet>
                                    </xsl:if>                                    
                                 </lido:event>
                                </lido:eventSet>
                               </xsl:if>
                                <xsl:if test="owner_hist.acquired_from[2] | owner_hist.owner[2] | owner_hist.date.start[2] | owner_hist.date.end[2] | owner_hist.place[2] | owner_hist.acquisition.method[2] | owner_hist.notes[2]"> 
                                  <lido:eventSet>
                                    <lido:event>
                                        <lido:eventType>
                                            <lido:term>provenance</lido:term>
                                        </lido:eventType>
                                        <!-- idereen die 'bron' is van een verwering -->
                                        <xsl:if test="owner_hist.acquired_from[2]">
                                        <lido:eventActor>            
                                            <lido:actorInRole>
                                                <lido:actor>
                                                    <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.acquired_from.lref[2]"/></lido:actorID>
                                                    <lido:nameActorSet>
                                                        <lido:appellationValue><xsl:value-of select="./owner_hist.acquired_from[2]/name"/></lido:appellationValue>
                                                    </lido:nameActorSet>
                                                </lido:actor>
                                                <lido:roleActor><lido:term>repeller</lido:term></lido:roleActor>
                                            </lido:actorInRole>
                                        </lido:eventActor>
                                        </xsl:if>
                                        <!-- idereen die 'doel' is van een verwering -->
                                        <xsl:if test="owner_hist.owner[2]">
                                            <lido:eventActor>
                                                <lido:actorInRole>
                                                    <lido:actor>
                                                        <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.owner.lref[2]"/></lido:actorID>
                                                        <lido:nameActorSet>
                                                            <lido:appellationValue><xsl:value-of select="./owner_hist.owner[2]/name"/></lido:appellationValue>
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
                                                    <lido:placeID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.place.lref[2]"/></lido:placeID>
                                                    <lido:namePlaceSet>
                                                        <lido:appellationValue><xsl:value-of select="./owner_hist.place[2]/term"/></lido:appellationValue>
                                                    </lido:namePlaceSet>
                                                </lido:place>
                                            </lido:eventPlace>
                                        </xsl:if>
                                        <xsl:if test="owner_hist.acquisition.method[2]">
                                            <lido:eventMethod>
                                                <lido:conceptID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.acquisition.method.lref[2]"/></lido:conceptID>
                                                <lido:term><xsl:value-of select="./owner_hist.acquisition.method[2]/term"/></lido:term>
                                            </lido:eventMethod>
                                        </xsl:if>
                                        <xsl:if test="owner_hist.notes[2]">
                                            <lido:eventDescriptionSet>
                                                <lido:descriptiveNoteValue><xsl:value-of select="./owner_hist.notes[2]"/></lido:descriptiveNoteValue>
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
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.acquired_from.lref[3]"/></lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="./owner_hist.acquired_from[3]/name"/></lido:appellationValue>
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
                                                            <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.owner.lref[3]"/></lido:actorID>
                                                            <lido:nameActorSet>
                                                                <lido:appellationValue><xsl:value-of select="./owner_hist.owner[3]/name"/></lido:appellationValue>
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
                                                        <lido:placeID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.place.lref[3]"/></lido:placeID>
                                                        <lido:namePlaceSet>
                                                            <lido:appellationValue><xsl:value-of select="./owner_hist.place[3]/term"/></lido:appellationValue>
                                                        </lido:namePlaceSet>
                                                    </lido:place>
                                                </lido:eventPlace>
                                            </xsl:if>
                                            <xsl:if test="owner_hist.acquisition.method[3]">
                                                <lido:eventMethod>
                                                    <lido:conceptID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.acquisition.method.lref[3]"/></lido:conceptID>
                                                    <lido:term><xsl:value-of select="./owner_hist.acquisition.method[3]/term"/></lido:term>
                                                </lido:eventMethod>
                                            </xsl:if>
                                            <xsl:if test="owner_hist.notes[3]">
                                                <lido:eventDescriptionSet>
                                                    <lido:descriptiveNoteValue><xsl:value-of select="./owner_hist.notes[3]"/></lido:descriptiveNoteValue>
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
                                                           <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.acquired_from.lref[4]"/></lido:actorID>
                                                           <lido:nameActorSet>
                                                               <lido:appellationValue><xsl:value-of select="./owner_hist.acquired_from[4]/name"/></lido:appellationValue>
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
                                                           <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.owner.lref[4]"/></lido:actorID>
                                                           <lido:nameActorSet>
                                                               <lido:appellationValue><xsl:value-of select="./owner_hist.owner[4]/name"/></lido:appellationValue>
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
                                                       <lido:placeID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.place.lref[4]"/></lido:placeID>
                                                       <lido:namePlaceSet>
                                                           <lido:appellationValue><xsl:value-of select="./owner_hist.place[4]/term"/></lido:appellationValue>
                                                       </lido:namePlaceSet>
                                                   </lido:place>
                                               </lido:eventPlace>
                                           </xsl:if>
                                           <xsl:if test="owner_hist.acquisition.method[4]">
                                               <lido:eventMethod>
                                                   <lido:conceptID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.acquisition.method.lref[4]"/></lido:conceptID>
                                                   <lido:term><xsl:value-of select="./owner_hist.acquisition.method[4]/term"/></lido:term>
                                               </lido:eventMethod>
                                           </xsl:if>
                                           <xsl:if test="owner_hist.notes[4]">
                                               <lido:eventDescriptionSet>
                                                   <lido:descriptiveNoteValue><xsl:value-of select="./owner_hist.notes[4]"/></lido:descriptiveNoteValue>
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
                                                           <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.acquired_from.lref[5]"/></lido:actorID>
                                                           <lido:nameActorSet>
                                                               <lido:appellationValue><xsl:value-of select="./owner_hist.acquired_from[5]/name"/></lido:appellationValue>
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
                                                           <lido:actorID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.owner.lref[5]"/></lido:actorID>
                                                           <lido:nameActorSet>
                                                               <lido:appellationValue><xsl:value-of select="./owner_hist.owner[5]/name"/></lido:appellationValue>
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
                                                       <lido:placeID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.place.lref[5]"/></lido:placeID>
                                                       <lido:namePlaceSet>
                                                           <lido:appellationValue><xsl:value-of select="./owner_hist.place[5]/term"/></lido:appellationValue>
                                                       </lido:namePlaceSet>
                                                   </lido:place>
                                               </lido:eventPlace>
                                           </xsl:if>
                                           <xsl:if test="owner_hist.acquisition.method[5]">
                                               <lido:eventMethod>
                                                   <lido:conceptID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./owner_hist.acquisition.method.lref[5]"/></lido:conceptID>
                                                   <lido:term><xsl:value-of select="./owner_hist.acquisition.method[5]/term"/></lido:term>
                                               </lido:eventMethod>
                                           </xsl:if>
                                           <xsl:if test="owner_hist.notes[5]">
                                               <lido:eventDescriptionSet>
                                                   <lido:descriptiveNoteValue><xsl:value-of select="./owner_hist.notes[5]"/></lido:descriptiveNoteValue>
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
            
            ===>>> lijkt erop dat Exhibition en Loan_out vaak verdubbeling is.
            -->        
                        
                            <!-- een exhibition event voor elke Exhibition/exhibition node. resterende gegevens binnen de Exhibition node worden genegeerd. -->
                                <xsl:if test="Exhibition">
                                    <xsl:for-each select="./Exhibition">
                                        <lido:eventSet>
                                            <lido:event>
                                                <!-- local ID voor tentoonstellingen -->
                                                <lido:eventID lido:type="local"><xsl:value-of select="./exhibition/reference_number"/></lido:eventID>
                                                <lido:eventID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./exhibition.lref"/></lido:eventID>
                                                <!-- default waarde exhibition -->
                                                <lido:eventType><lido:term>exhibition</lido:term></lido:eventType>
                                                <!-- titel van de tentoonstelling -->
                                                <lido:eventName>
                                                    <lido:appellationValue><xsl:value-of select="./exhibition/title"/></lido:appellationValue>
                                                </lido:eventName>
                                                <!-- organisator -->
                                                <xsl:if test="./exhibition/organiser">
                                                    <lido:eventActor>
                                                        <lido:actorInRole>
                                                            <lido:actor>
                                                                <lido:nameActorSet>
                                                                    <lido:appellationValue><xsl:value-of select="./exhibition/organiser"/></lido:appellationValue>
                                                                </lido:nameActorSet>
                                                            </lido:actor>
                                                            <lido:roleActor><lido:term>organiser</lido:term></lido:roleActor>
                                                        </lido:actorInRole>
                                                    </lido:eventActor>
                                                </xsl:if>
                                                <!-- periode van de tentoonstelling -->
                                                <xsl:if test="./exhibition/date.end or ./exhibition/date.start">
                                                    <lido:eventDate>
                                                        <lido:displayDate><xsl:value-of select="./exhibition/date.start"/>;<xsl:value-of select="./exhibition/date.end"/></lido:displayDate>
                                                        <lido:date>
                                                            <lido:earliestDate></lido:earliestDate>
                                                            <lido:latestDate></lido:latestDate>
                                                        </lido:date>
                                                    </lido:eventDate>
                                                </xsl:if>
                                                <!-- locatie tentoonstelling: venue en venue.place -->
                                                <xsl:if test="./exhibition/venue or ./exhibition/venue.place">
                                                    <lido:eventPlace>
                                                        <lido:place>
                                                            <lido:namePlaceSet>
                                                                <lido:appellationValue><xsl:value-of select="./exhibition/venue"/>;<xsl:value-of select="./exhibition/venue.place"/></lido:appellationValue>
                                                            </lido:namePlaceSet>
                                                        </lido:place>
                                                    </lido:eventPlace>
                                                </xsl:if>
                                                <xsl:if test="./exhibition.notes">
                                                    <lido:eventDescriptionSet>
                                                        <lido:descriptiveNoteValue><xsl:value-of select="./exhibition.notes"/></lido:descriptiveNoteValue>
                                                    </lido:eventDescriptionSet>
                                                </xsl:if>
                                            </lido:event>
                                        </lido:eventSet>
                                    </xsl:for-each>
                                </xsl:if>
                                
                                <!-- een exhibition event voor elke loan_out node. -->
                                <xsl:if test="Loan_out">
                                    <xsl:for-each select="./Loan_out">
                                        <lido:eventSet>
                                            <lido:event>
                                                <!-- local ID voor bruiklenen -->
                                                <lido:eventID lido:type="local loan ID"><xsl:value-of select="./loan.out.number/loan_number"/></lido:eventID>
                                                <lido:eventID lido:type="local loan ID" lido:label="Adlib database number"><xsl:value-of select="./loan.out.number.lref"/></lido:eventID>
                                                <!-- default waarde exhibition -->
                                                <lido:eventType><lido:term>exhibition</lido:term></lido:eventType>
                                                <!-- titel van de tentoonstelling -->
                                                <lido:eventName>
                                                    <lido:appellationValue><xsl:value-of select="./loan.out.exhibition/title"/></lido:appellationValue>
                                                </lido:eventName>
                                                <!-- organisator -->
                                                <xsl:if test="./loan.out.requester">
                                                    <lido:eventActor>
                                                        <lido:actorInRole>
                                                            <lido:actor>
                                                                <lido:nameActorSet>
                                                                    <lido:appellationValue><xsl:value-of select="./loan.out.requester"/></lido:appellationValue>
                                                                </lido:nameActorSet>
                                                            </lido:actor>
                                                            <lido:roleActor><lido:term>organiser</lido:term></lido:roleActor>
                                                        </lido:actorInRole>
                                                    </lido:eventActor>
                                                </xsl:if>
                                                <!-- periode van de tentoonstelling=periode bruikleen -->
                                                <xsl:if test="loan.out.request.period.start or loan.out.request.period.end">
                                                    <lido:eventDate>
                                                        <lido:displayDate><xsl:value-of select="./loan.out.request.period.start"/>;<xsl:value-of select="./loan.out.request.period.end"/></lido:displayDate>
                                                        <lido:date>
                                                            <lido:earliestDate></lido:earliestDate>
                                                            <lido:latestDate></lido:latestDate>
                                                        </lido:date>
                                                    </lido:eventDate>
                                                </xsl:if>
                                                <xsl:if test="loan.out.status">
                                                    <lido:eventDescriptionSet>
                                                        <lido:descriptiveNoteValue><xsl:value-of select="./loan.out.status"/></lido:descriptiveNoteValue>
                                                    </lido:eventDescriptionSet>
                                                </xsl:if>
                                                
                                            </lido:event>
                                        </lido:eventSet>
                                        
                                        
                                    </xsl:for-each>
                                </xsl:if>
                            
                            
                            <!--Publication
            ID              Documentation/documentation.title.lref
            auteur          Documentation/documentation.author
            titel           Documentation/documentation.title
            pagina          Documentation.documentation.page_reference (todo volgende fase?)
            -->
                            
                            
                            <!-- een publication event voor elke Documentation node. -->
                                <xsl:if test="Documentation">
                                    <xsl:for-each select="./Documentation">
                                        <lido:eventSet>
                                            <lido:event>
                                                <!-- local ID voor publicaties in de Adlib Bibliotheek catalogus -->
                                                <lido:eventID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./documentation.title.lref"/></lido:eventID>
                                                <!-- default waarde publication -->
                                                <lido:eventType><lido:term>publication</lido:term></lido:eventType>
                                                <!-- titel van de publicatie -->
                                                <lido:eventName>
                                                    <lido:appellationValue><xsl:value-of select="./documentation.title/title"/></lido:appellationValue>
                                                </lido:eventName>
                                                <!-- organisator -->
                                                <xsl:if test="./documentation.author">
                                                    <lido:eventActor>
                                                        <lido:actorInRole>
                                                            <lido:actor>
                                                                <lido:nameActorSet>
                                                                    <lido:appellationValue><xsl:value-of select="./documentation.author"/></lido:appellationValue>
                                                                </lido:nameActorSet>
                                                            </lido:actor>
                                                            <lido:roleActor><lido:term>author</lido:term></lido:roleActor>
                                                        </lido:actorInRole>
                                                    </lido:eventActor>
                                                </xsl:if>
                                                <xsl:if test="./documentation.notes">
                                                    <lido:eventDescriptionSet>
                                                        <lido:descriptiveNoteValue><xsl:value-of select="./documentation.notes"/></lido:descriptiveNoteValue>
                                                    </lido:eventDescriptionSet>
                                                </xsl:if>
                                            </lido:event>
                                        </lido:eventSet>
                                    </xsl:for-each>
                                </xsl:if>
                        
                                <!-- een research event voor elke research node. -->
                                <xsl:if test="Research">
                                    <xsl:for-each select="./Research">
                                        <lido:eventSet>
                                            <lido:event>
                                                <!-- local ID voor publicaties in de Adlib Bibliotheek catalogus -->
                                                <lido:eventID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./research.reference_number.lref"/></lido:eventID>
                                                <lido:eventID lido:type="local" lido:label="Adlib database number"><xsl:value-of select="./research.reference_number/reference_number"/></lido:eventID>
                                                <!-- default waarde research -->
                                                <lido:eventType><lido:term>research</lido:term></lido:eventType>
                                                
                                                <!-- author -->
                                                <xsl:if test="./research.researcher">
                                                    <lido:eventActor>
                                                        <lido:actorInRole>
                                                            <lido:actor>
                                                                <lido:nameActorSet>
                                                                    <lido:appellationValue><xsl:value-of select="./research.researcher"/></lido:appellationValue>
                                                                </lido:nameActorSet>
                                                            </lido:actor>
                                                            <lido:roleActor><lido:term>author</lido:term></lido:roleActor>
                                                        </lido:actorInRole>
                                                    </lido:eventActor>
                                                </xsl:if>
                                                <xsl:if test="./research.date.start or ./research.date.end">
                                                    <lido:eventDate>
                                                        <lido:displayDate><xsl:value-of select="./research.date.start"/>;<xsl:value-of select="./research.date.end"/></lido:displayDate>
                                                        <lido:date>
                                                            <lido:earliestDate></lido:earliestDate>
                                                            <lido:latestDate></lido:latestDate>
                                                        </lido:date>
                                                    </lido:eventDate>
                                                </xsl:if>
                                                <xsl:if test="./research.notes">
                                                    <lido:eventDescriptionSet>
                                                        <lido:descriptiveNoteValue><xsl:value-of select="./research.notes"/></lido:descriptiveNoteValue>
                                                    </lido:eventDescriptionSet>
                                                </xsl:if>
                                            </lido:event>
                                        </lido:eventSet>
                                    </xsl:for-each>
                                </xsl:if>
                        
                                <!--Restoration en condition assessment
                
            ID                    Condition ????? 
            auteur                Condition/condition.check.name
            date                  Condition/condition.date
            titel                 Condition/condition/term
            eventDescriptionSet   Condition/condition.notes
            
           
            Bij SMAK worden 'treatment' en 'conservator' velden verder niet ingevuld
            -->
                        
                                <!-- een condition assessment event voor elke Condition node. -->
                                <xsl:if test="Condition">
                                    <xsl:for-each select="./Condition">
                                        <lido:eventSet>
                                            <lido:event>
                                                <!-- wat is de ID van een Condition Check? voorlopig een default waarde-->
                                                <lido:eventID lido:type="?"></lido:eventID>
                                                <!-- default waarde condition assessment E14 volgens Cidoc-CRM http://www.cidoc-crm.org/html/5.0.4/cidoc-crm.html#E14-->
                                                <lido:eventType><lido:term>condition assessment</lido:term></lido:eventType>
                                                <!-- label van de check -->
                                                <lido:eventName>
                                                    <lido:appellationValue><xsl:value-of select="./condition/term"/></lido:appellationValue>
                                                </lido:eventName>
                                                <!-- uitvoerder van de condition check -->
                                                <xsl:if test="./condition.check.name">
                                                    <lido:eventActor>
                                                        <lido:actorInRole>
                                                            <lido:actor>
                                                                <lido:nameActorSet>
                                                                    <lido:appellationValue><xsl:value-of select="./condition.check.name"/></lido:appellationValue>
                                                                </lido:nameActorSet>
                                                            </lido:actor>
                                                            <lido:roleActor><lido:term>condition inspector</lido:term></lido:roleActor>
                                                        </lido:actorInRole>
                                                    </lido:eventActor>
                                                </xsl:if>
                                                <xsl:if test="./condition.date">
                                                    <lido:eventDate>
                                                        <lido:displayDate><xsl:value-of select="./condition.date"/></lido:displayDate>
                                                        <lido:date>
                                                            <lido:earliestDate></lido:earliestDate><lido:latestDate></lido:latestDate>
                                                        </lido:date>
                                                    </lido:eventDate>
                                                </xsl:if>
                                                <xsl:if test="condition.notes">
                                                    <lido:eventDescriptionSet>
                                                        <lido:descriptiveNoteValue><xsl:value-of select="./condition.notes"/></lido:descriptiveNoteValue>
                                                    </lido:eventDescriptionSet>
                                                </xsl:if>
                                            </lido:event>
                                        </lido:eventSet>
                                    </xsl:for-each>
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
                                        <lido:appellationValue>S.M.A.K.</lido:appellationValue>
                                    </lido:legalBodyName>
                                </lido:recordSource>
                            </lido:recordWrap>
                        </lido:administrativeMetadata>
                </lido:lido>

                </xsl:for-each>

            </lido:lidoWrap>
        </xsl:template>
</xsl:stylesheet>